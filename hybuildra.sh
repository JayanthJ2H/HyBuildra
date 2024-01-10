#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
magenta="\033[35m"
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
white="\033[37m"
black="\033[30m"

bold='\033[1m'

author(){

  echo -e "${white}[${RED} H Y${NC}${white} B U I L ${RED}D R A ${NC}${white}]${NC} ${YELLOW}Author :${NC} ${BLUE}https://www.github.com/jayanthj2h${NC}"

}
s(){
    echo -e "${YELLOW}SAMPLE${NC}" 
    echo "" 
}
sample(){

    echo -e "${GREEN}Target[Host/IP]:${NC} 127.0.0.1"
    echo ""
    echo -e "${GREEN}Method[Get/Post]:${NC} post"
    echo ""
    echo -e "${GREEN}Target_page:${NC} /panel/login.php"
    echo ""
    echo -e "${GREEN}Failure response:${NC} Invalid credentials!${NC}"
}


find_password_sample(){
      s
      echo -e "${GREEN}username:${NC} Jayanth"
      echo ""
      echo -e "${GREEN}password:${NC} /usr/share/wordlists/rockyou.txt"
      echo ""
      sample
      echo ""
}

find_username_sample(){
       s
       echo -e "${GREEN}user.txt:${NC} usernames.txt"
       echo ""
       echo -e "${GREEN}password:${NC} p@ssW0rd123"
       echo ""
       sample      
       echo ""
}

find_both_sample(){
       s
       echo -e "${GREEN}user.txt:${NC} username.txt"
       echo ""
       echo -e "${GREEN}password.txt:${NC} usr/share/wordlists/rockyou.txt"
       echo ""
       sample
       echo ""
}

menu(){
	clear
	author
	echo -e "${RED}=====================================${NC}"
	echo -e "${YELLOW}1.Find username"
	echo ""
	echo -e "2.Find password"
	echo ""
	echo -e "3.Find both${NC}"
	echo -e "${RED}=====================================${NC}"	
	read -r choice
	echo -e "${RED}=====================================${NC}"
	selection
}

selection(){
       if [[ "$choice" == '1' ]]; then  
           
           find_username_sample
	       echo -e "${RED}=====================================${NC}"
           echo -n -e "${BLUE}user.txt: ${NC} "
           read -r user_txt
           echo ""
           echo -n -e "${BLUE}password: ${NC} "
           read -r password 
           echo ""
           loginpage_details
           username_bruteforce
       
       elif [[ "$choice" == '2' ]]; then
           
           find_password_sample
	       echo -e "${RED}=====================================${NC}"           
           echo -n -e "${BLUE}username:${NC} "
           read -r username
           echo ""
           echo -n -e "${BLUE}password.txt:${NC} "
           read -r passwd_txt
           echo ""
           loginpage_details
           password_bruteforce
       
       elif [[ "$choice" == '3' ]]; then
            
          find_both_sample
	      echo -e "${RED}=====================================${NC}"          
          echo -n -e "${BLUE}user.txt:${NC} "
          read -r user_txt
          echo ""
          echo -n -e "${BLUE}password.txt:${NC} "
          read -r passwd_txt
          echo ""
          
          loginpage_details
          both_bruteforce
          
       else 
          clear
          menu
       fi

}



loginpage_details(){

	echo -n -e "${BLUE}Target[Host/IP]:${NC} "
	read -r host
    echo ""
	echo -n -e "${BLUE}Method[Get/Post]:${NC} "
	read -r method
    echo ""
	echo -n -e "${BLUE}Target_page:${NC} " 
	read -r path
    echo ""
	echo -n -e "${BLUE}Failure response:${NC} "
	read -r fail
	echo ""
echo -e "${YELLOW}=======================================================================================================================================================${NC}"

}

username_bruteforce(){
echo hydra -L "$user_txt" -p "$password" "$host" http-"$method"-form "\"$path:username=^USER^&&password=^PASS^:F=$fail\"" -V 
echo -e "${YELLOW}=======================================================================================================================================================${NC}"
}


password_bruteforce(){
	echo hydra -l "$username" -P "$passwd_txt" "$host" http-"$method"-form "\"$path:username=^USER^&&password=^PASS^:F=$fail\"" -V 
echo -e "${YELLOW}=======================================================================================================================================================${NC}"
}

both_bruteforce(){
	echo hydra -L "$user_txt" -P "$passwd_txt" "$host" http-"$method"-form "\"$path:username=^USER^&&password=^PASS^:F=$fail\"" -V 
echo -e "${YELLOW}========================================================================================================================================================${NC}"

}

menu
