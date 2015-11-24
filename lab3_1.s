.text
.global main
main : 

      # Adding the switches value into register 1
      lw $1, 0x73000 ($0)
      
      # Storing the value inside right SSD
      sw $1, 0x73003 ($0) 
      
      # Shifting the left 4 bits for left SSD
      srli $1, $1, 4
      
      # Storing inside the left SSD
      sw  $1, 0x73002 ($0)
      
      j main
      
