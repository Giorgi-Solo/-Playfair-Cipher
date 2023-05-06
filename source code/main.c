#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int singleletter(char keyword[]){
    int i,j,l;
    int counter=0;
    for(i=0;i<strlen(keyword);++i){
        if(keyword[i]=='-'){
                ++counter;
            for(l=i+1;l<=strlen(keyword);++l){
                keyword[l-1]=keyword[l];
            }
        }
    }
    return counter;
}
int fillTheTable(int table[], char keyword[]){
    int i=0;
    int j,k,l,m;
    int f=0;

    for(i=0;i<strlen(keyword);++i){// checks if one letter is more than once
        for(j=i+1;j<strlen(keyword);++j){
            if(keyword[i]==keyword[j]){
                keyword[i] = '-';
                break;
            }
        }
    }
    int counter=1;
    while(counter) counter=singleletter(keyword);

    for(i=0;i<strlen(keyword);++i) table[i] = (int)keyword[i];

    l=i;
    for(j=97;j<122;++j){
            f=0;
        for(k=0;k<i;++k){
            if(j==table[k]){
                f=1;
            }
            if(f==1) break;
        }
        if(f==1) continue;

        table[i]=j;
        l++;
        i++;
    }
    return j;
}

void asciivalues(char text[], int inttext[]){
    int i;
    for(i=0;i<strlen(text);++i) inttext[i] = text[i];
}
void reverseAscii(char text[], int inttext[]){
    int i;
    for(i=0;i<strlen(text);++i)
    text[i] = inttext[i];
}
void gotoxy(int x, int y){
    int i=0;
    for(i=0;i<y;++i) printf("\n");
    for(i=0;i<x;++i) printf(" ");
}
void display(){
    int* indexofchoice;
    int num = 1;
    indexofchoice = &num;
    system("cls");
    system("color 0A");
    gotoxy(34,4);
    printf("E N C R Y P T I O N / D E C R Y P T I O N\n");
    gotoxy(44,1);
    printf("%d. ENCRYPTION\n",*indexofchoice);
    gotoxy(44,1);
    printf("%d. DECRYPTION\n",(*indexofchoice)+1);
    gotoxy(44,1);
    printf("%d. QUIT\n",(*indexofchoice)+2);
    gotoxy(44,1);
    printf("Enter Your Choice: ");
}
int main()
{
    char keyword[100];
    int table[25];
    char text[10000];
    int i,omittedLetter,k;
    char userchar[2];

    display();
    gets(userchar);
    system("cls");


            if(userchar[0]=='3') return 0;

    if(userchar[0]=='1'){
            while(1){
    printf("Enter the Keyword: ");
    gets(keyword);
    printf("\nEnter the text: ");
    gets(text);
    if(strlen(text)%2!=0) strcat(text," ");
    int inttext[strlen(text)];
    asciivalues(text,inttext);

    fillTheTable(table,keyword);
    omittedLetter=FindMissingLetter(table);

    for(i=0;i<(strlen(text)-1);i=i+2)
    k=Encryption(&inttext[i],&inttext[i+1],table,omittedLetter);

    reverseAscii(text,inttext);
    printf("\nEncrypted text: %s\n",text);

    printf("Do you want to Encrypt again? (y/n) ");
    gets(userchar);
    if(userchar[0]=='n'||userchar[0]=='N') return main();

    system("cls");}
    }
    else if(userchar[0]=='2'){
            while(1){
    printf("Enter the Keyword: ");
    gets(keyword);
    printf("Enter the text: ");
    gets(text);
    if(strlen(text)%2!=0) strcat(text," ");
    int inttext[strlen(text)];
    asciivalues(text,inttext);

    fillTheTable(table,keyword);
    omittedLetter=FindMissingLetter(table);

    for(i=0;i<(strlen(text)-1);i=i+2)
    k=Dencryption(&inttext[i],&inttext[i+1],table,omittedLetter);

    reverseAscii(text,inttext);
    printf("\nDecrypted text: %s\n",text);

    printf("Do you want to Decrypt again? (y/n) ");
    gets(userchar);
    if(userchar[0]=='n'||userchar[0]=='N') return main();

    system("cls");}
    }

    return 0;
}

