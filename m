Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Bruce.Ashfield@windriver.com>) id 1RsGaf-0007sf-9w
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jan 2012 17:29:53 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0VETR0t018090
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 31 Jan 2012 06:29:27 -0800 (PST)
Received: from [128.224.146.67] (128.224.146.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 31 Jan 2012 06:29:27 -0800
Message-ID: <4F27FABA.9070304@windriver.com>
Date: Tue, 31 Jan 2012 09:29:14 -0500
From: Bruce Ashfield <bruce.ashfield@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:8.0) Gecko/20111124 Thunderbird/8.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1328019536.13744.28.camel@ted>
In-Reply-To: <1328019536.13744.28.camel@ted>
X-Mailman-Approved-At: Wed, 01 Feb 2012 16:21:03 +0100
Cc: "Hart, Darren" <darren.hart@intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Add workaround for clone using alternates problem
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 31 Jan 2012 16:29:53 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 12-01-31 09:18 AM, Richard Purdie wrote:
> To quote my report of this to the git mailing list:
> """
>
>      I have a problem with git clone commands using alternates failing by
>      mixing up different repositories. I have a situation where I could end
>      up with both:
>
>      /srv/mirrors/repo
>      /srv/mirrors/repo.git
>
>      as bare clones.
>
>      I then try cloning "repo" with alternates with the command:
>
>      $ git clone -s -n /srv/mirrors/repo /tmp/foo
>      Cloning into /tmp/foo...
>      done.
>
>      $ cat /tmp/foo/.git/objects/info/alternates
>      /srv/mirrors/repo.git/objects
>
>      Note how I'm now referencing repo.git, not repo. This doesn't work as
>      expected giving some very bizarre results when actually using the
>      repository.
>
>      I appreciate this is a rather bizarre corner case but its one that is
>      breaking the build system I work with. Ideally people would use a
>      consistent URL for the same repository but we have an example where they
>      haven't and this really shouldn't break like this.
>
>      Looking at the code, the cause seems to be
>
>      clone.c:get_repo_path():
>              static char *suffix[] = { "/.git", ".git", "" };
>
>      since its looking in order for:
>       repo/.git (fails)
>       repo.git (suceeds, incorrect)
>       repo (never looked at)
>
>      I'm not sure what would break if that order were to change, swapping the
>      last two options.
>
>      I can "force" the issue by running:
>
>      git clone -s -n /srv/mirrors/repo/ /tmp/foo
>
>      but this results in the slightly odd looking:
>
>      $ cat /tmp/foo/.git/objects/info/alternates
>
>      /srv/mirrors/repo//objects
>
>      which does at least work.
> """
>
> This patch adds the trailing slash to ensure the correct repository is
> referenced at the expense of some ugliness in the alternates file.

For what it's worth, I've run into very similar issues in the past, and
the solution was the same .. Ensure that the trailing / was present, it
is meaningful to git in a few cases (in mine it was relative references
to alternate repositories).

In the relative reference case, we eventually did propose and got a variant
of our change to support it incorporated into git. But the work around
was still needed for a while, since waiting for it to propagate to
supported hosts and versions of git was a bit messy.

I couldn't find a good explanation of the ordering either, but I do know
that there are existing scripts and infrastructure that do depend on
having <foo>.git found before <foo>, so changing any ordering could
have some subtle impacts.

The summary of my rambling is that I couldn't come up with anything
better in my poking around before I've had much coffee today :)

Cheers,

Bruce



>
> Signed-off-by: Richard Purdie<richard.purdie@linuxfoundation.org>
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index d833714..fb0260a 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -220,7 +220,7 @@ class Git(FetchMethod):
>           if os.path.exists(destdir):
>               bb.utils.prunedir(destdir)
>
> -        runfetchcmd("git clone -s -n %s %s" % (ud.clonedir, destdir), d)
> +        runfetchcmd("git clone -s -n %s/ %s" % (ud.clonedir, destdir), d)
>           if not ud.nocheckout:
>               os.chdir(destdir)
>               if subdir != "":
>



