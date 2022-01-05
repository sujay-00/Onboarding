# node class
class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value=value
    @left=nil
    @right=nil
  end
end

# BST class
class BST
  attr_accessor :root, :size

  def initialize()
    @root=nil
    @size=0
  end

  # to insert elements in BST
  def insert(value)
    if @root==nil
      @root=TreeNode.new(value)
    else
      curr_node=@root
      previous_node=@root

      while(curr_node!=nil)
        previous_node=curr_node
        if value<curr_node.value
          curr_node=curr_node.left

        else curr_node=curr_node.right
        end
      end
      if value<previous_node.value
        previous_node.left=TreeNode.new(value)
      else
        previous_node.right=TreeNode.new(value)
      end
    end
    @size+=1
  end

  # to find the maximum element in the BST
  def largest()
    if @root==nil
      puts "there is no element in the bst"
    else
      curr_node=@root
      while (curr_node.right!=nil)
        curr_node=curr_node.right
      end
      return curr_node.value
    end
  end  

  # to find the smallest element in the BST
  def smallest()
    if @root==nil
      puts "there is no element in th bst "
    else
      curr_node=@root
      while(curr_node.left!=nil)
        curr_node=curr_node.left
      end
      return curr_node
    end

  end

  # inorder traversal
  def inorder(node=self.root)
    if node==nil
      return nil
    end

    inorder(node.left)
    print "#{node.value} "
    inorder(node.right)
  end

  # preorder traversal
  def preorder(node=self.root)
    if node==nil
      return nil
    end
    print"#{node.value} "
    preorder(node.left)
    preorder(node.right)
  end

  # postorder traversal
  def postorder(node=self.root)
    if node==nil
      return nil
    end

    postorder(node.left)
    postorder(node.right)
    print "#{node.value} "
  end

  # to search an element in BST
  def search(node=self.root,value)
    if node==nil
      puts"there is no such value in this tree"
    end
    if (node.value==value)
      puts "yes this value is present"
    elsif(node.value<value)
      search(node.right,value)
    elsif(node.value>value)
      search(node.left,value)
    end
  end

  def remove(value,node=self.root)
    delete(value,node=self.root)
    @size-=1
    node
  end

  def delete(value,node=self.root)
    if node==nil
      return nil
    end

    if node.value>value
      node.left=delete(value,node.left)
    elsif node.value<value
      node.right=delete(value,node.right)
    else
      if node.left!=nil && node.right!=nil
        temp=node
        min=smallest(node.right)
        node.value=min
        node.right=delete(min.value,node.right)
      elsif node.left!=nil
        node=node.left
      elsif node.right!=nil
        node=node.right
      else node=nil
      end
    end
    return node
  end

  def isleaf(node)
    return node.left==nil && node.right==nil
  end

  def printallpaths(node,path)
    if node==nil 
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
    path=[]
    printallpaths(node,path)
  end

end
btree=BST.new()

puts "press 1 if you want to make a nwe bst "
puts "press any other key to load your last bst"

a=gets.chomp.to_i
if (a==1)
puts"insert the no of elements you want to insert into the bst"
num=gets.chomp.to_i
cnt=num
puts "insert the elements into the bst"
tree=[]
while num>0
  a=gets.chomp.to_i
  tree.push(a)
  num=num-1
end
else
  tree=File.read("sample_tree").split
end
i=0
while i<cnt
  btree.insert(tree[i])
  i=i+1
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

  a=gets.chomp.to_i
  case a
  when 1  
    puts "largest number in the bst is"
    x=btree.largest()
    puts "#{x}"

  when 2
    puts "smallest number in the bst is"
    x=btree.smallest()
    puts "#{x.value}"

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
    sch=gets.chomp.to_i
    btree.search(sch)

  when 7
    puts"Insert the element you want to delete"
    del=gets.chomp.to_i
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
