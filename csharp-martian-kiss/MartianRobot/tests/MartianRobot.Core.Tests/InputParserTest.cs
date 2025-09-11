using MartianRobot.Core;

namespace MartianRobot.Core.Tests;

public class InputParserTest
{
    [Fact]
    public void Parse_ValidInput_ReturnsCorrectSimulatorParams()
    {
        // Arrange
        var input = """
            5 3
            1 1 E
            RFRFRFRF
            3 2 N
            FRRFLLFFRRFLL
            0 3 W
            LLFFFLFLFL
            """;

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(5, result.Grid.Max.X);
        Assert.Equal(3, result.Grid.Max.Y);
        Assert.Equal(3, result.Robots.Count);

        // First robot
        Assert.Equal(1, result.Robots[0].start.Coordinate.X);
        Assert.Equal(1, result.Robots[0].start.Coordinate.Y);
        Assert.Equal(Direction.E, result.Robots[0].start.Direction);
        Assert.Equal("RFRFRFRF", result.Robots[0].instr);

        // Second robot
        Assert.Equal(3, result.Robots[1].start.Coordinate.X);
        Assert.Equal(2, result.Robots[1].start.Coordinate.Y);
        Assert.Equal(Direction.N, result.Robots[1].start.Direction);
        Assert.Equal("FRRFLLFFRRFLL", result.Robots[1].instr);

        // Third robot
        Assert.Equal(0, result.Robots[2].start.Coordinate.X);
        Assert.Equal(3, result.Robots[2].start.Coordinate.Y);
        Assert.Equal(Direction.W, result.Robots[2].start.Direction);
        Assert.Equal("LLFFFLFLFL", result.Robots[2].instr);
    }

    [Fact]
    public void Parse_SingleRobot_ReturnsCorrectSimulatorParams()
    {
        // Arrange
        var input = """
            10 10
            5 5 N
            FLR
            """;

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(10, result.Grid.Max.X);
        Assert.Equal(10, result.Grid.Max.Y);
        Assert.Single(result.Robots);
        Assert.Equal(5, result.Robots[0].start.Coordinate.X);
        Assert.Equal(5, result.Robots[0].start.Coordinate.Y);
        Assert.Equal(Direction.N, result.Robots[0].start.Direction);
        Assert.Equal("FLR", result.Robots[0].instr);
    }

    [Fact]
    public void Parse_NoRobots_ReturnsGridOnly()
    {
        // Arrange
        var input = "5 3";

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(5, result.Grid.Max.X);
        Assert.Equal(3, result.Grid.Max.Y);
        Assert.Empty(result.Robots);
    }

    [Fact]
    public void Parse_EmptyInput_ThrowsArgumentException()
    {
        // Arrange
        var input = "";

        // Act & Assert
        var exception = Assert.Throws<ArgumentException>(() => InputParser.Parse(input));
        Assert.Equal("Empty input", exception.Message);
    }

    [Fact]
    public void Parse_InvalidGridLine_ThrowsArgumentException()
    {
        // Arrange
        var input = "5"; // Only one number instead of two

        // Act & Assert
        var exception = Assert.Throws<ArgumentException>(() => InputParser.Parse(input));
        Assert.Contains("Line 1 must contain at least 2 numbers", exception.Message);
    }

    [Fact]
    public void Parse_InvalidDirection_ThrowsArgumentException()
    {
        // Arrange
        var input = """
            5 3
            1 1 X
            RFRFRFRF
            """;

        // Act & Assert
        Assert.Throws<ArgumentException>(() => InputParser.Parse(input));
    }

    [Fact]
    public void Parse_IncompleteRobotData_IgnoresIncompleteRobot()
    {
        // Arrange
        var input = """
            5 3
            1 1 E
            RFRFRFRF
            3 2 N
            """; // Missing instruction line for second robot

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result.Robots); // Only the complete robot is included
    }


    [Fact]
    public void Parse_MultipleRobotsWithDifferentInstructions_ParsesCorrectly()
    {
        // Arrange
        var input = """
            5 5
            0 0 N
            FF
            2 2 E
            LRF
            4 4 S
            FFFF
            """;

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(3, result.Robots.Count);

        // Verify each robot's instructions are correctly parsed
        Assert.Equal("FF", result.Robots[0].instr);
        Assert.Equal("LRF", result.Robots[1].instr);
        Assert.Equal("FFFF", result.Robots[2].instr);
    }

    [Fact]
    public void Parse_LargeGridCoordinates_ParsesCorrectly()
    {
        // Arrange
        var input = """
            50 50
            25 25 S
            FLFLFLFL
            """;

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(50, result.Grid.Max.X);
        Assert.Equal(50, result.Grid.Max.Y);
        Assert.Equal(25, result.Robots[0].start.Coordinate.X);
        Assert.Equal(25, result.Robots[0].start.Coordinate.Y);
        Assert.Equal(Direction.S, result.Robots[0].start.Direction);
    }

    [Fact]
    public void Parse_AllDirections_ParsesCorrectly()
    {
        // Arrange
        var input = """
            10 10
            1 1 N
            F
            2 2 E
            F
            3 3 S
            F
            4 4 W
            F
            """;

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(4, result.Robots.Count);
        Assert.Equal(Direction.N, result.Robots[0].start.Direction);
        Assert.Equal(Direction.E, result.Robots[1].start.Direction);
        Assert.Equal(Direction.S, result.Robots[2].start.Direction);
        Assert.Equal(Direction.W, result.Robots[3].start.Direction);
    }

    [Fact]
    public void Parse_ZeroCoordinates_ParsesCorrectly()
    {
        // Arrange
        var input = """
            5 5
            0 0 N
            FRF
            """;

        // Act
        var result = InputParser.Parse(input);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(0, result.Robots[0].start.Coordinate.X);
        Assert.Equal(0, result.Robots[0].start.Coordinate.Y);
    }

    [Fact]
    public void Parse_InvalidNumber_ThrowsFormatException()
    {
        // Arrange
        var input = """
            5 ABC
            1 1 N
            F
            """;

        // Act & Assert
        Assert.Throws<FormatException>(() => InputParser.Parse(input));
    }
}
