#!/usr/bin/env sh
set -eu

awk '
function trim(s){ sub(/^\s+/,"",s); sub(/\s+$/,"",s); return s }
function left(d){ return d=="N"?"W":d=="W"?"S":d=="S"?"E":d=="E"?"N":d }
function right(d){ return d=="N"?"E":d=="E"?"S":d=="S"?"W":d=="W"?"N":d }
function step(d, a){ if(d=="N"){a[1]=0;a[2]=1}else if(d=="E"){a[1]=1;a[2]=0}else if(d=="S"){a[1]=0;a[2]=-1}else if(d=="W"){a[1]=-1;a[2]=0}else{a[1]=0;a[2]=0} }
BEGIN{ OFS=" "; n=0 }
{ line=trim($0); if(length(line)>0) { L[++n]=line } }
END{
  if(n==0){ print "No input provided" > "/dev/stderr"; exit 1 }
  split(L[1], h, /[ \t]+/); if(length(h)<2){ print "Invalid header" > "/dev/stderr"; exit 1 }
  MX=h[1]+0; MY=h[2]+0
  i=2
  while(i+1<=n){
    split(L[i], p, /[ \t]+/); x=p[1]+0; y=p[2]+0; d=p[3]
    instr=L[i+1]
    lost=0
    for(k=1;k<=length(instr);k++){
      if(lost) break
      c=substr(instr,k,1)
      if(c=="L") d=left(d)
      else if(c=="R") d=right(d)
      else if(c=="F"){
        step(d, a); nx=x+a[1]; ny=y+a[2]
        if(!(0<=nx && nx<=MX && 0<=ny && ny<=MY)){
          key=sprintf("%d,%d,%s", x,y,d)
          if(!(key in SC)) { SC[key]=1; lost=1 }
        } else { x=nx; y=ny }
      }
    }
    printf("%d %d %s%s\n", x,y,d, lost?" LOST":"")
    i+=2
  }
  print ""
}'
