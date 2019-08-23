class ResponseUserInfoEntity {
	String gistsUrl;
	String reposUrl;
	String followingUrl;
	String starredUrl;
	String login;
	String followersUrl;
	String type;
	String blog;
	String url;
	String subscriptionsUrl;
	String receivedEventsUrl;
	String avatarUrl;
	String eventsUrl;
	String htmlUrl;
	bool siteAdmin;
	String name;
	dynamic company;
	String location;
	int id;
	String gravatarId;
	String nodeId;
	String organizationsUrl;

	ResponseUserInfoEntity({this.gistsUrl, this.reposUrl, this.followingUrl, this.starredUrl, this.login, this.followersUrl, this.type, this.blog, this.url, this.subscriptionsUrl, this.receivedEventsUrl, this.avatarUrl, this.eventsUrl, this.htmlUrl, this.siteAdmin, this.name, this.company, this.location, this.id, this.gravatarId, this.nodeId, this.organizationsUrl});

	ResponseUserInfoEntity.fromJson(Map<String, dynamic> json) {
		gistsUrl = json['gists_url'];
		reposUrl = json['repos_url'];
		followingUrl = json['following_url'];
		starredUrl = json['starred_url'];
		login = json['login'];
		followersUrl = json['followers_url'];
		type = json['type'];
		blog = json['blog'];
		url = json['url'];
		subscriptionsUrl = json['subscriptions_url'];
		receivedEventsUrl = json['received_events_url'];
		avatarUrl = json['avatar_url'];
		eventsUrl = json['events_url'];
		htmlUrl = json['html_url'];
		siteAdmin = json['site_admin'];
		name = json['name'];
		company = json['company'];
		location = json['location'];
		id = json['id'];
		gravatarId = json['gravatar_id'];
		nodeId = json['node_id'];
		organizationsUrl = json['organizations_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['gists_url'] = this.gistsUrl;
		data['repos_url'] = this.reposUrl;
		data['following_url'] = this.followingUrl;
		data['starred_url'] = this.starredUrl;
		data['login'] = this.login;
		data['followers_url'] = this.followersUrl;
		data['type'] = this.type;
		data['blog'] = this.blog;
		data['url'] = this.url;
		data['subscriptions_url'] = this.subscriptionsUrl;
		data['received_events_url'] = this.receivedEventsUrl;
		data['avatar_url'] = this.avatarUrl;
		data['events_url'] = this.eventsUrl;
		data['html_url'] = this.htmlUrl;
		data['site_admin'] = this.siteAdmin;
		data['name'] = this.name;
		data['company'] = this.company;
		data['location'] = this.location;
		data['id'] = this.id;
		data['gravatar_id'] = this.gravatarId;
		data['node_id'] = this.nodeId;
		data['organizations_url'] = this.organizationsUrl;
		return data;
	}
}
