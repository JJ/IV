#Recipe for installing emacs and creating a directory and a file
package 'emacs'
directory '/home/jmerelo/Documentos'
file "/home/jmerelo/Documentos/LEEME" do
  owner "jmerelo"
  group "jmerelo"
  mode 00544
  action :create
  content "Directorio para documentos diversos"
end
