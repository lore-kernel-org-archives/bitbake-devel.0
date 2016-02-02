Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 89A6C771A9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 14:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 80BDD2E16C;
	Tue,  2 Feb 2016 15:51:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id OucrxmYpbJVT; Tue,  2 Feb 2016 15:51:14 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 9D88E2E19F;
	Tue,  2 Feb 2016 15:51:04 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 86B021264;
	Tue,  2 Feb 2016 15:51:02 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 7991A105D;
	Tue,  2 Feb 2016 15:51:02 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 6FEAD341FC;
	Tue,  2 Feb 2016 15:51:02 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0;
	Tue, 2 Feb 2016 15:51:01 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 2A3DD9C075; 
	Tue,  2 Feb 2016 15:51:02 +0100 (CET)
Date: Tue, 2 Feb 2016 15:51:02 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <20160202145101.GV31212@axis.com>
References: <1454422078.27087.76.camel@linuxfoundation.org>
	<CAJTo0LanTJT6B4YJ6=xfetCSi882LOBAd5P0gNXeXyC=pqiJLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJTo0LanTJT6B4YJ6=xfetCSi882LOBAd5P0gNXeXyC=pqiJLQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [Openembedded-architecture] [PATCH] build/data: Don't expand python functions before execution [API change]
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
X-List-Received-Date: Tue, 02 Feb 2016 14:51:16 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 16-02-02 14:41 +0000, Burton, Ross wrote:
> On 2 February 2016 at 14:07, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> 
> > I propose we default to not expanding python code and then deal with
> > any consequences from that if/as/where identified. This will improve
> > new user understanding and usability of the system, it also allows
> > several long standing weird expansion issues to be fixed.
> >
> 
> As someone who has had to write classes that do "$" + "{FOO}", this gets a
> massive +1 from me.

Indeed, it's a very welcome change from my point of view! +1

-- 
olofjn

