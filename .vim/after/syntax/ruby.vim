" for rspec
if expand('%') =~# '_spec\.rb$'
  syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its
endif

hi def link rubyRspec Function
