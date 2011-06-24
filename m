Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QaBBW-00084n-DC
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Jun 2011 20:32:54 +0200
Received: by mail-vx0-f175.google.com with SMTP id 37so2446092vxa.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2011 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:from
	:date:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=Xrkix1Suqrz/Mq9YRPGFqXosWDxKpA0/rcdT7T6PZKU=;
	b=izK7RhmRIIRQR09Dlf7KmZfKeJ356+uGrzcl/hbCG955yZ1hHc+UVpzmQXPdPJZzle
	rgsR9c7rFvBhtWoF+mJ21Ggh6NiQN+lOmIlHK0JAn4pDclSEQ0gFwZ2so4FMvE70h8hO
	ZbRVynJXp7Tn41/9NUNvZeFbJVtjGEk5q2j8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	b=vhKM1F275jJ6/CHmLKHZpwlRFXu+utufGVu30kE8Eg6XsohYXiyaoLV6PkyZ3Z2VnN
	3deiBIwsrQToZM7fo8UAbITGFYSYxxHSqHA0mQTz6GTg4Gafm3ZNphYWwTRcCTGHuYPu
	d1cRuD3ly/xnwQHOguMPEEAGfU3mNLc/xwOGc=
Received: by 10.52.111.71 with SMTP id ig7mr5072490vdb.209.1308939433107; Fri,
	24 Jun 2011 11:17:13 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.181.2 with HTTP; Fri, 24 Jun 2011 11:16:53 -0700 (PDT)
In-Reply-To: <1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 24 Jun 2011 11:16:53 -0700
X-Google-Sender-Auth: VuWrHcEZuFaTWBTumJF7OMrTbfM
Message-ID: <BANLkTinGUdo-ar4NHN6zgfvS7Gf4F3USYQ@mail.gmail.com>
To: "Cui, Dexuan" <dexuan.cui@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Fri, 24 Jun 2011 18:32:54 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Jun 20, 2011 at 12:29 AM, Cui, Dexuan <dexuan.cui@intel.com> wrote:
> Martin Jansa wrote:
>> On Mon, Jun 20, 2011 at 6:34 AM, Dexuan Cui <dexuan.cui@intel.com>
>> wrote:
>>> This patch moves the logic of show_appends_with_no_recipes from
>>> bitbake-layers into bitbake, and makes the script die with a fatal
>>> error message printed.
>>
>> I agree that this is problem, but I'm not sure if it should be fatal.
>>
>> Imagine the case when you enable some layer managed by someone else
>> (lets call it LS) and you're using different oe-core revision, maybe
>> current HEAD and that LS wasn't updated for that or vice versa you're
>> using some oe-core release version and you want to reuse some recipes
>> from LS in current version.
>>
>> I think that big fat warning that some .bbappends does not match
>> should be enough to decide if it's fatal for me (and I'll kill that
>> build) or that's fine (when I'm not interested in those .bbappends
>> from LS and I'm using only some other .bb files from LS).
>>
>> If we make it fatal then I would be forced to remove unmatched
>> .bbappends from LS before build which can be difficult to share
>> (unless I create own LS branch and use it in my distro).
> Thanks a lot for the explanation!
> So looks we may as well change the "bb.fatal" to "bb.error"(that is not fatal and wouldn't be ignored by bitbake-layers).
> This is the new patch (on a new branch dcui/bb-v2):
> http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=dcui/bb-v2&id=2a520959f71ec2cd80ed2088bfcf082631161a1a
>

Are you sure this shouldn't be a warning? Remember that any error
displayed results in a non-zero exit code from bitbake.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


