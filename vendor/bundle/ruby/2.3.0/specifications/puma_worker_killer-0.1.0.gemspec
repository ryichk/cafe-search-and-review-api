# -*- encoding: utf-8 -*-
# stub: puma_worker_killer 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "puma_worker_killer".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Richard Schneeman".freeze]
  s.date = "2017-05-12"
  s.description = " Kills pumas, the code kind ".freeze
  s.email = ["richard.schneeman+rubygems@gmail.com".freeze]
  s.homepage = "https://github.com/schneems/puma_worker_killer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "If you have a memory leak in your web code puma_worker_killer can keep it in check.".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<puma>.freeze, ["< 4", ">= 2.7"])
      s.add_runtime_dependency(%q<get_process_mem>.freeze, ["~> 0.2"])
      s.add_development_dependency(%q<rack>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<wait_for_it>.freeze, ["~> 0.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    else
      s.add_dependency(%q<puma>.freeze, ["< 4", ">= 2.7"])
      s.add_dependency(%q<get_process_mem>.freeze, ["~> 0.2"])
      s.add_dependency(%q<rack>.freeze, ["~> 1.6"])
      s.add_dependency(%q<wait_for_it>.freeze, ["~> 0.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<puma>.freeze, ["< 4", ">= 2.7"])
    s.add_dependency(%q<get_process_mem>.freeze, ["~> 0.2"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.6"])
    s.add_dependency(%q<wait_for_it>.freeze, ["~> 0.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end
