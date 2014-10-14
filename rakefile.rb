# coding:utf-8


# hexo version 2.5.7


cmds = %w{ clean generate server deploy }
cmds.each do |cmd|
  desc "hexo #{cmd}"
  task cmd do
    system "hexo #{cmd}"
  end
end

desc "备份到hexo分支"
task 'backup' do
  system 'git add --all'
  system "git commit -a -m \"backup at #{Time.now.to_s.slice(0..-7)}\""
  system 'git push origin hexo'
end

desc "clean -> generate -> deploy -> backup"
task :remote => ['clean','generate','deploy','backup']

desc "clean -> generate -> server"
task :local => ['clean','generate','server']