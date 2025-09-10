#include <bits/stdc++.h>
using namespace std;

struct Scent { int x,y; char d; };

static inline bool inside(int x,int y,int mx,int my){ return 0<=x && x<=mx && 0<=y && y<=my; }
static inline pair<int,int> step(char d){ if(d=='N') return {0,1}; if(d=='E') return {1,0}; if(d=='S') return {0,-1}; if(d=='W') return {-1,0}; return {0,0}; }
static inline char leftc(char d){ if(d=='N') return 'W'; if(d=='W') return 'S'; if(d=='S') return 'E'; if(d=='E') return 'N'; return d; }
static inline char rightc(char d){ if(d=='N') return 'E'; if(d=='E') return 'S'; if(d=='S') return 'W'; if(d=='W') return 'N'; return d; }

int main(){
    ios::sync_with_stdio(false); cin.tie(nullptr);
    string all, line; string tmp;
    {
        ostringstream oss; oss<<cin.rdbuf(); all = oss.str();
    }
    auto trim = [](string s){
        auto l = s.find_first_not_of(" \t\r\n"); if(l==string::npos) return string();
        auto r = s.find_last_not_of(" \t\r\n"); return s.substr(l, r-l+1);
    };
    if(trim(all).empty()){ cerr<<"No input provided\n"; return 1; }
    vector<string> lines; {
        string cur; stringstream ss(all); while(getline(ss,cur)) { cur=trim(cur); if(!cur.empty()) lines.push_back(cur); }
    }
    if(lines.empty()){ cerr<<"Empty input\n"; return 1; }
    int mx,my; {
        stringstream ss(lines[0]); if(!(ss>>mx>>my)){ cerr<<"Invalid header\n"; return 1; }
    }
    vector<Scent> scents; scents.reserve(64);
    auto has = [&](int x,int y,char d){ for(auto &s:scents) if(s.x==x&&s.y==y&&s.d==d) return true; return false; };
    for(size_t i=1;i+1<lines.size();i+=2){
        int x,y; char d; { stringstream ss(lines[i]); ss>>x>>y>>d; }
        string instr = lines[i+1]; bool lost=false;
        for(char c: instr){ if(lost) break; if(c=='L') d=leftc(d); else if(c=='R') d=rightc(d); else if(c=='F') { auto [dx,dy]=step(d); int nx=x+dx, ny=y+dy; if(!inside(nx,ny,mx,my)){ if(has(x,y,d)) continue; scents.push_back({x,y,d}); lost=true; } else { x=nx; y=ny; } } }
        cout<<x<<" "<<y<<" "<<d<<(lost?" LOST":"")<<"\n";
    }
    cout<<"\n";
    return 0;
}
