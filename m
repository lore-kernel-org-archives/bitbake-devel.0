Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0837D60112;
	Wed,  3 Feb 2016 08:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1380ULo025284; Wed, 3 Feb 2016 08:00:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Fkl5ohBSTHWD; Wed,  3 Feb 2016 08:00:30 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1380PhL025240
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Feb 2016 08:00:26 GMT
Message-ID: <1454486425.27087.149.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Khem Raj <raj.khem@gmail.com>
Date: Wed, 03 Feb 2016 08:00:25 +0000
In-Reply-To: <CAMKF1spSfcfM-AAC4fPNUiRykQaZ0_zUpzQNFfb8nOOeS7t8-g@mail.gmail.com>
References: <1454457337.27087.142.camel@linuxfoundation.org>
	<CAMKF1spSfcfM-AAC4fPNUiRykQaZ0_zUpzQNFfb8nOOeS7t8-g@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVarFlag [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 08:00:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-02-02 at 21:36 -0800, Khem Raj wrote:
> On Tue, Feb 2, 2016 at 3:55 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > At some point in the future, getVarFlag should expand by default.
> > To
> > get there from the current position, we need a period of time where
> > the
> > expand parameter is mandatory.
> > 
> 
> what are advantages of this.

Most users expect the data to be expanded by default. Most call sites
also use getVar(xxx, True), its uncommon to see expand=False, outside
the core of bitbake.

So the ultimate advantage is a more sensible default which is what the
user expects and leads to neater/smaller code.

We have had several bugs requesting this and it does confuse people.

I have heard regrets from some of the original developers that the
default wasn't True as well.

Cheers,

Richard


