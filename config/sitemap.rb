# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://cafeshares.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/'
  #
     add root_path
     add places_path, :priority => 0.7, :changefreq => 'daily'
     add reviews_path, :priority => 0.7, :changefreq => 'daily'
     add users_path, :priority => 0.7, :changefreq => 'daily'

    Place.find_each do |place|
      add place_path(place.id), :lastmod => place.updated_at
    end

    Review.find_each do |review|
      add review_path(review.id), :lastmod => review.updated_at
    end

    User.find_each do |user|
      add user_path(user.id), :lastmod => user.updated_at
    end

  # # Add all articles:
  # #
  #   Article.find_each do |article|
  #     add root_path(article), :lastmod => article.updated_at
  #   end
end
