class Graphs
  def initialize
    @arr = Array.new(8) { Array.new(8,Nodes.new()) }
    @arr.each_with_index do |sub_array, i|
     sub_array.each_with_index do |item, j|
       @arr[i][j] = Nodes.new(i,j)
     end
    end
    @arr.flatten
  end

  def knights_moves(first_vertice,second_vertice,nodes=@arr)
    mod_arr =  knights_moves_of(first_vertice,second_vertice,nodes)
    kt_arr = []
    kt_arr.push(mod_arr.pop)
    mod_arr.reverse_each do |element|
     (nodes[element[0]][element[1]].edges).any? do |ele|
       if ele == kt_arr[0]
          kt_arr.unshift(element)
       end
      end
    end
    return kt_arr
  end

def knights_moves_of(first_vertice,second_vertice,nodes=@arr,newArr=[],self_arr = [])
  if self_arr.include?(second_vertice)
    return self_arr
  else
      self_arr.push(first_vertice)
      edges_arr = nodes[first_vertice[0]][first_vertice[1]].edges
      edges_arr.each do | element |
        unless newArr.include?(element)
          unless self_arr.include?(element)
            newArr.push(element)
          end
        end
      end
      while newArr.length!=0
        mod_arr = newArr.shift
        if mod_arr == second_vertice
            self_arr.push(mod_arr)
            return self_arr
        end
        unless newArr.include?(mod_arr)
          knights_moves_of(mod_arr,second_vertice,nodes=@arr,newArr,self_arr)
        end
      end
  end
  return self_arr
end


end



class Nodes
  attr_accessor :vertices, :edges

  @@transform = [[-2,-1],[-1,-2],[1,-2],[2,-1],[2,1],[1,2],[-1,2],[-2,1]]
  def initialize(i=0,j=0)
    @vertices = [i,j]
    @edges= build_edges(@vertices)
  end

  def build_edges(vertices)
    arr = []
    @@transform.each do |element|
      a = vertices[0] + element[0]
      b = vertices[1] + element[1]
      if  a >= 0 and a <= 7
          if b >= 0 and b <= 7
            arr2=[a,b]
            arr.push(arr2)
          end
      end
    end
    return arr
  end

end

g = Graphs.new
p g
p g.knights_moves([3,3],[4,3])
