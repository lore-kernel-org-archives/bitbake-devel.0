Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 944F86B88F;
	Wed, 11 Dec 2013 22:58:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBBMwTre001696; Wed, 11 Dec 2013 22:58:29 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JDYWW3IG18Xd; Wed, 11 Dec 2013 22:58:29 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBBMwPf6001687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Dec 2013 22:58:27 GMT
Message-ID: <1386802700.504.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 11 Dec 2013 22:58:20 +0000
In-Reply-To: <20131211225150.GB3717@jama>
References: <20131211225150.GB3717@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] git fetcher sanity check for matching branch and SRCREV
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
X-List-Received-Date: Wed, 11 Dec 2013 22:58:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-12-11 at 23:51 +0100, Martin Jansa wrote:
> I understand and support reasons behind recently added commit
> "fetch2/git: Add sanity check to ensure we really did fetch the correct
> revisions"
> 
> but there is at least one corner case which IMHO isn't supported now, in
> meta-webos we have yajl recipe with:
> 
> # corresponds to tag 1.0.12
> SRCREV = "17b1790fb9c8abbb3c0f7e083864a6a014191d56"
> SRC_URI = "git://github.com/lloyd/${PN}"
> 
> the problem is that 17b1790fb9c8abbb3c0f7e083864a6a014191d56 exists only
> in 1.0.12 tag and not in any branch
> 
> OE @ ~/webos/projects/yajl $ git branch -a --contains
> 17b1790fb9c8abbb3c0f7e083864a6a014191d56
> OE @ ~/webos/projects/yajl $ git tag --contains
> 17b1790fb9c8abbb3c0f7e083864a6a014191d56
> 1.0.12
> 
> There is "1.x" branch which contains parent of
> 17b1790fb9c8abbb3c0f7e083864a6a014191d56 but is missing this one commit.
> 
> Unfortunately we cannot "disable" this check by explicitly setting empty
> branch or setting tag=1.0.12
> 
> I can ask yajl owner to push that one missing patch to 1.x branch, but
> there were no changes in last 11 months so I don't know how responsive
> he will be and there could be similar case in different recipes where
> the upstream could be completely gone.
> 
> As side note, should bitbake do the same check when tag=foo is
> specified?

This is an interesting corner case. I have this patch lying around which
fixes the issue where a given tag is only available in specific
branches:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/t2&id=d211662ca92ee084c0c4a3d343e0b1f28ab853ac

however that won't help this case. There is also an issue where the
ls-remote command can match multiple branches/tags since its unanchored:

git ls-remote X foo

refs/heads/foo
refs/heads/broken/foo
refs/tags/foo
refs/tags/broken/foo

All things considered the check is proving useful as its finding some
real issue however we have a few corner cases to iron out...

Cheers,

Richard





