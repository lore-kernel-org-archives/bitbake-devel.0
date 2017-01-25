Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6B57C71E52
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jan 2017 11:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0PBCxtC020598; Wed, 25 Jan 2017 11:12:59 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CLRC4ACXabXa; Wed, 25 Jan 2017 11:12:59 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0PBCwnE020594
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 25 Jan 2017 11:12:59 GMT
Message-ID: <1485342777.30673.79.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jan 2017 11:12:57 +0000
In-Reply-To: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
References: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] cooker: Drop package-depends.dot and pn-depends.dot generation
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
X-List-Received-Date: Wed, 25 Jan 2017 11:13:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2017-01-25 at 11:05 +0000, Peter Kjellerstedt wrote:
> > 
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> > Sent: den 23 januari 2017 23:38
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] cooker: Drop package-depends.dot
> > and
> > pn-depends.dot generation
> > 
> > A long time ago when we switched to task basked execution we added
> > task-depends.dot and generated package-depends.dot and pn-
> > depends.dot
> > for compatibility as best we could.	
> > 
> > The problem is they contain partial data about the taskgraph, its
> > incomplete and tends to confuse users.
> > 
> > I propose we remove the two compatibilty outputs and just generate
> > the one which contains definitive data.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Is there any alternative to removing package-depends.dot and 
> especially pn-depends.dot?

We don't have to remove them but what worries me is that the data in
them is incomplete. Its some subset of what the real task graph looks
like and at some point someone is going to complain the data was
inaccurate/misleading (which it is).

>  The reason I ask is because we use 
> pn-dependes.dot when visualizing the dependencies between packages. 
> Even though task-depends.dot is more complete, trying to render it 
> is near impossible given the sheer number of nodes and edges it 
> contains. Already visualizing pn-depends.dot is hard but possible 
> with some gvpr and tred filtering. Here are some statistics from 
> one of my typical builds:
> 
>                         Nodes  Edges
>                         -----  ------
> pn-depends.dot           1183   12087
> package-depends.dot      5939   55615
> task-depends.dot        13756  125870
> 
> As can be seen, the number of nodes and edges in task-depends.dot 
> is a magnitude greater than in pn-depends.dot.

Its certainly simpler, but the data is just plain buggy. I'm not sure
I'd trust anything those files told me, even if they are easier to
view.

I appreciate task-depends is hard to load graphically, it is helpful
even as a text file though, I do use it a lot since its a near direct
dump of bitbake's internal parsed task dependencies.

Cheers,

Richard


