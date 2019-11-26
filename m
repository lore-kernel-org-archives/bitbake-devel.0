Return-Path: <andre.draszik@gmail.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id C2ACE7FC81
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2019 09:40:52 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id n188so2487280wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2019 01:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=ocmdEUxSFqR33aGLoaJxtISsldoyZ+EU9INcvu+AKXk=;
	b=nLqm3W1GT11P92vWEt/QEotGltLqdtPP+HTvzeMNcBzoLkCK6xyAbhU85oaZKR8SVM
	wdelq4mAVqsvKEaEqExJZIGY0INiuaVjv4REjrwaHBpRs8aRWuQCsbUlxgDpdpk2XgqW
	tceDktyxZ5Y2pwbnAuV3SfM7/enGCuud/Ile7ZgFCol2Zd6IvtqIe7QeygaqiRdgtkGy
	W0P09dPCWOn54OGH8hkk1DlI71CEi1sMGKI30lvd0TEUrsXC7lBRFHIaGLx9QcBspt0W
	YoQm81E66cJYwLcWw8HgRfsKe9URJfgVoLlrJ9F31D2AydlUrfG6ukd3OsICM5d3S9M1
	kXoA==
X-Gm-Message-State: APjAAAWTWH5DuJhi0vMsPhYOrJj6Echrss1lund7G3aZpuHkyIZkFIjF
	Qaji+b2V9GnwVEF52g9hjvQEp6mc
X-Google-Smtp-Source: APXvYqzzFlVFfoNiovPxfN3+j9EYTW6cPNYhlqjkjDrGK59dlNV8aigSAuM6Qt8cIGxTl7XCTJE+qA==
X-Received: by 2002:a05:600c:149:: with SMTP id
	w9mr140345wmm.132.1574761253415; 
	Tue, 26 Nov 2019 01:40:53 -0800 (PST)
Received: from tfsielt31850 ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	m15sm14015486wrq.97.2019.11.26.01.40.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 26 Nov 2019 01:40:52 -0800 (PST)
Message-ID: <84d7813c801887d697d24798965f4fc4763336c1.camel@andred.net>
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
To: Ross Burton <ross.burton@intel.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 26 Nov 2019 09:40:52 +0000
In-Reply-To: <83d558f5-b153-b3ca-d4b7-eca7b37e78c3@intel.com>
References: <20191114142131.29829-1-git@andred.net>
	<83d558f5-b153-b3ca-d4b7-eca7b37e78c3@intel.com>
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: Re: [master][PATCH] fetch2/wget: support releases from private github repositories
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 26 Nov 2019 09:40:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Ross,

On Fri, 2019-11-22 at 17:01 +0000, Ross Burton wrote:
> On 14/11/2019 14:21, André Draszik wrote:
> > The wget / http fetcher currently doesn't support fetching
> > assets attached to releases on private GitHub repositories,
> > i.e. release artefacts like
> >      https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt
> > 
> > Those are special, in that HTTP basic auth is not used / possible
> > on the URL as seen in the GitHub UI, but instead the GitHub API
> > must be used for downloading (which does support HTTP basic auth)
> > where the URL will be different.
> > 
> > To be able to access the GitHub API, opportunistic authentication
> > (auth-no-challenge) needs to be enabled. Then the API needs to
> > be queried for the real URL of the file to be downloaded, and
> > finally application/octet-stream must be specified explicitly.
> > 
> > Note that there is a slight difference in the location of the
> > REST API endpoints between GitHub.com and GitHub Enterprise.
> > 
> >      https://developer.github.com/v3/repos/releases/
> >      https://developer.github.com/enterprise/2.19/v3/enterprise-admin/
> > 
> > As it's impossible to determine if a repository is on GitHub
> > or not (considering GitHub Enterprise), and even more so if a
> > repository is private or not, a new flag is introduced that
> > should be set to "1" - "github_private_asset", e.g.
> 
> That's a lot of "special" and "unfortunately" and "but", adding a 
> site-specific option and a non-trivial site-specific chunk of code to 
> the otherwise generic HTTP fetcher.
> 
> I'd suggest implementing this as a new fetcher instead of shoe-horning 
> it into the wget fetcher.  Then you can do something like githubasset:// 
> in SRC_URI and the fetcher can do the right thing instead of jumping 
> through hoops and guessing.

Thanks for your comments. Yes, I was in two minds about it as well. I was also
contemplating a new bbclass for this instead of a new fetcher for github
private repositories.

I'll write a new fetcher and see how that will work out...


Thanks,
Andre'



