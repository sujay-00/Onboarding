# node class
class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

#node class of linked list
class List_node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end

class LinkedList
  def initialize()
    @head = nil
  end

  def add(value)
    if @head == nil
      @head=List_node.new(value)
    else
      curr_node = @head
      while curr_node.next
        curr_node = curr_node.next
      end
      curr_node.next = List_node.new(value)
    end
  end

  def search(value)
    curr_node = @head
    while curr_node != nil
      if curr_node.value == value
        puts "this value is present"
        break
      end
      curr_node=curr_node.next
    end
    if !curr_node
      puts "this value is not present"
    end
  end
    def delete(value)
      curr_node = @head
      prev_node = nil
      while curr_node
        if @head != nil && @head.value == value
          @head = curr_node.next    
        end

        if curr_node && curr_node.value == value
          prev_node.next = curr_node.next
          print()        
          break

        elsif curr_node && curr_node.value != value
          prev_node = curr_node
          curr_node = curr_node.next
        end
        if !curr_node
          return nil
        end
      end
    end

    def print()
      curr_node = @head
      while curr_node
        puts curr_node.value
        curr_node = curr_node.next
      end
    end

    def reverse()
      curr = @head
      nex = @head
      prev = nil
      while curr
        nex = curr.next
        curr.next = prev
        prev = curr
        curr = nex
      end
      @head=prev
    end
  end
  # BST class
  class BST
    attr_accessor :root, :size

    def initialize()
      @root = nil
      @size = 0
    end

    # to insert elements in BST
    def insert(value)
      if @root == nil
        @root=TreeNode.new(value)
      else
        curr_node = @root
        previous_node = @root

        while curr_node
          previous_node = curr_node
          if value < curr_node.value
            curr_node = curr_node.left

          else curr_node = curr_node.right
          end
        end
        if value<previous_node.value
          previous_node.left = TreeNode.new(value)
        else
          previous_node.right = TreeNode.new(value)
        end
      end
      @size += 1
    end

    # to find the maximum element in the BST
    def largest()
      if @root == nil
        puts "there is no element in the bst"
      else
        curr_node = @root
        while curr_node.right
          curr_node = curr_node.right
        end
        return curr_node.value
      end
    end  

    # to find the smallest element in the BST
    def smallest(node)
      if @root == nil
        puts "there is no element in th bst "
      else
        curr_node = node
        while(curr_node.left)
          curr_node = curr_node.left
        end
        return curr_node
      end
    end

    # inorder traversal
    def inorder(node = self.root)
      if node == nil
        return nil
      end

      inorder(node.left)
      print node.value
      inorder(node.right)
    end

    # preorder traversal
    def preorder(node = self.root)
      if node == nil
        return nil
      end
      print node.value
      preorder(node.left)
      preorder(node.right)
    end

    # postorder traversal
    def postorder(node=self.root)
      if node == nil
        return nil
      end

      postorder(node.left)
      postorder(node.right)
      print node.value
    end

    # to search an element in BST
    def search(node = self.root,value)
      if node == nil
        puts"there is no such value in this tree"
      end
      if (node.value == value)
        puts "yes this value is present"
      elsif(node.value<value)
        search(node.right,value)
      elsif(node.value>value)
        search(node.left,value)
      end
    end

    def remove(value,node = self.root)
      delete(value,node = self.root)
      @size -= 1
      node
    end

    def delete(value,node = self.root)
      if node == nil
        return nil
      end

      if node.value>value
        node.left = delete(value,node.left)
      elsif node.value < value
        node.right = delete(value,node.right)
      else
        if node.left && node.right
          min = smallest(node.right)
          node.value = min.value
          node.right = delete(min.value,node.right)
        elsif node.left
          node = node.left
        elsif node.right
          node = node.right
        else node = nil
        end
      end
      return node
    end


    def isleaf(node)
      return node.left == nil && node.right == nil
    end

    def printallpaths(node,path)
      if node == nil 
        return nil
      end
      path.append(node.value)
      if isleaf(node)
        for i in path
          puts i
        end
        puts" "
      end
      printallpaths(node.left,path)
      printallpaths(node.right,path)
      path.pop()
    end

    def printroottoleafpaths(node)
      path = []
      printallpaths(node,path)
    end
  end

  puts "Enter 1 to make operations in BST"
  puts "Enter 2 to make operations in Linked lists"

  a = gets.chomp.to_i
  if(a == 1)
    puts "press 1 if you want to make a new bst "
    puts "press any other key to load your last bst"
    btree = BST.new()
    a = gets.chomp.to_i
    if a == 1
      puts"insert the no of elements you want to insert into the bst"
      num = gets.chomp.to_i
      cnt = num
      puts "insert the elements into the bst"
      tree = []
      while num>0
        a = gets.chomp.to_i
        tree.push(a)
        num = num-1
      end
    else
      tree = File.read("sample_tree").split
    end
    i=0
    while i<cnt
      btree.insert(tree[i])
      i = i+1
    end

    puts "press 1 to find largest element"
    puts "perss 2 to find smallest element"
    puts "press 3 to find inorder traversal"
    puts "press 4 to find preorder traversal"
    puts "press 5 to find postorder traversal"
    puts "press 6 to search an element"
    puts "press 7 to remove an element"
    puts "press 8 to print all paths from root to leaf"
    puts "press 0 to exit"

    while true

      a = gets.chomp.to_i
      case a
      when 1  
        puts "largest number in the bst is"
        x = btree.largest()
        puts x

      when 2
        puts "smallest number in the bst is"
        x = btree.smallest(btree.root)
        puts x.value

      when 3
        btree.inorder()
        puts " "
      when 4
        btree.preorder()
        puts " "
      when 5
        btree.postorder()
        puts " "

      when 6
        puts"Insert the element you want to search"
        sch = gets.chomp.to_i
        btree.search(sch)

      when 7
        puts"Insert the element you want to delete"
        del = gets.chomp.to_i
        btree.remove(del)
        tree.delete(del)
        btree.inorder()
        puts " "

      when 8
        puts "here are all paths from root to leaf"
        btree.printroottoleafpaths(btree.root)
        puts " "
      when 0 
        break
        File.open("sample_tree","w+") do |f|
          f.puts(tree)
        end
      else 
        puts "Invalid input"
      end
    end
  end

  if(a == 2)
    puts "Enter the number of elements you want to add in the linked list"
    num = gets.chomp.to_i
    puts "insert the elements into the linked list"
    list = []
    while num > 0
      a = gets.chomp.to_i
      list.push(a)
      num=num-1
    end
    llist = LinkedList.new()
    for i in list
      llist.add(i)
    end

    llist.print()

    puts "press 1 to find element"
    puts "perss 2 to delete an element"
    puts "perss 3 to add an element"
    puts "press 4 to reverse the linked list"
    puts "press 0 to exit"

    loop do

      a = gets.chomp.to_i
      case a
      when 1  
       puts "Enter the element you want to search"
       b = gets.chomp.to_i
        llist.search(b)
      when 2
        puts "Enter the element you want to delete"
        b = gets.chomp.to_i
        llist.delete(b)
      when 3
        puts "Enter the element you want to add"
        b = gets.chomp.to_i
        llist.add(b)
        llist.print()
        puts " "
      when 4
        llist.reverse()
        llist.print()
        puts " "
      else
        break
      end
    end
  end

