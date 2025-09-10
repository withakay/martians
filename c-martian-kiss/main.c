#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <ctype.h>

typedef struct { int x,y; char d; } Scent;

int inside(int x,int y,int mx,int my){ return 0<=x && x<=mx && 0<=y && y<=my; }
void step(char d,int *dx,int *dy){
  switch(d){ case 'N': *dx=0; *dy=1; break; case 'E': *dx=1; *dy=0; break; case 'S': *dx=0; *dy=-1; break; case 'W': *dx=-1; *dy=0; break; default:*dx=0;*dy=0; }
}
char left(char d){ switch(d){ case 'N': return 'W'; case 'W': return 'S'; case 'S': return 'E'; case 'E': return 'N'; default: return d; } }
char right(char d){ switch(d){ case 'N': return 'E'; case 'E': return 'S'; case 'S': return 'W'; case 'W': return 'N'; default: return d; } }
int has_scent(Scent *s,int n,int x,int y,char d){ for(int i=0;i<n;i++){ if(s[i].x==x && s[i].y==y && s[i].d==d) return 1; } return 0; }

int main(){
  char buf[256];
  char *lines[4096]; int L=0;
  while(fgets(buf,sizeof(buf),stdin)){
    // trim
    size_t len = strlen(buf);
    while(len>0 && (buf[len-1]=='\n' || buf[len-1]=='\r')) buf[--len]='\0';
    // strip spaces both ends
    char *p=buf; while(isspace((unsigned char)*p)) p++;
    char *q=p+strlen(p); while(q>p && isspace((unsigned char)q[-1])) *--q='\0';
    if(*p){ lines[L]=strdup(p); L++; }
  }
  if(L==0){ fprintf(stderr,"Empty input\n"); return 1; }
  int mx,my; if(sscanf(lines[0],"%d %d",&mx,&my)!=2){ fprintf(stderr,"Invalid header\n"); return 1; }
  Scent scents[1024]; int sc=0;
  for(int i=1;i+1<L;i+=2){
    int x,y; char d; sscanf(lines[i],"%d %d %c",&x,&y,&d);
    char *instr = lines[i+1];
    int lost=0;
    for(size_t k=0; instr[k] && !lost; k++){
      char c = instr[k];
      if(c=='L') d=left(d);
      else if(c=='R') d=right(d);
      else if(c=='F'){
        int dx,dy; step(d,&dx,&dy); int nx=x+dx, ny=y+dy;
        if(!inside(nx,ny,mx,my)){
          if(has_scent(scents,sc,x,y,d)) continue;
          if(sc<1024){ scents[sc].x=x; scents[sc].y=y; scents[sc].d=d; sc++; }
          lost=1;
        } else { x=nx; y=ny; }
      } else { /* ignore unknown */ }
    }
    if(lost) printf("%d %d %c LOST\n",x,y,d); else printf("%d %d %c\n",x,y,d);
  }
  printf("\n");
  return 0;
}
