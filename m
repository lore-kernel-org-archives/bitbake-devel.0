Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9D1726CFF1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2014 12:43:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s08ChLcO009246; Wed, 8 Jan 2014 12:43:21 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jtTt27eOW7Vb; Wed,  8 Jan 2014 12:43:21 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s08ChGIl009242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jan 2014 12:43:17 GMT
Message-ID: <1389184991.6899.95.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 08 Jan 2014 12:43:11 +0000
In-Reply-To: <20140108113213.GV3709@jama>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
	<1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
	<20140103134343.GF3707@jama>
	<566cdb63dddc4dc28aa269289bf94ea8@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140106091245.GE3709@jama>
	<c4d074a69c9d4c29b77cdf0bd01f7f20@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140107144659.GR3709@jama>
	<10ed04d1db504750b8a54f0786735f50@DM2PR03MB399.namprd03.prod.outlook.com>
	<20140108113213.GV3709@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "Zongchun.Yu@freescale.com" <Zongchun.Yu@freescale.com>,
	"B40290@freescale.com" <B40290@freescale.com>,
	"ting.liu@freescale.com" <ting.liu@freescale.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Richard Schmitt <richard.schmitt@freescale.com>
Subject: Re: [PATCH 1/2] bitbake: fetch2/git: Add sanity check for SHA validity of tag
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
X-List-Received-Date: Wed, 08 Jan 2014 12:43:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-01-08 at 12:32 +0100, Martin Jansa wrote:
> > [Luo Zhenhua-B19537] You point is to show warning when SRCREV and tag are set, meanwhile SRCREV is not corresponding to the tag, right?
> 
> Yes

We have several different issues around and the moment and I'm worried
some cases are going to get lost. We really need a list of them along
with the planed fix. As I see it we have:

a) conflicting SRCREV and tag/rev url parameters

Plan: bb.error on this case asking the user to say what they want

b) dereferencing of tags when checking existance of commits

Plan: Add ^{} to ls-remote command to allow dereferencing

c) tags may get resolved to incorrect tags in sub directories

Plan: Need to anchor tag/branch search expression


What else are we missing?


Ideally we could do with examples of these in the fetcher test code
too...

Cheers,

Richard





