Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 8EB396BC1F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 10:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id CB82419D82;
	Tue,  7 Jan 2014 11:36:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cuOGJGI0WRYg; Tue,  7 Jan 2014 11:36:06 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 593FA19D79;
	Tue,  7 Jan 2014 11:36:04 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 36E9EA5F;
	Tue,  7 Jan 2014 11:36:04 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 28949965;
	Tue,  7 Jan 2014 11:36:04 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 2484634070;
	Tue,  7 Jan 2014 11:36:04 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.255.0; Tue, 7 Jan 2014 11:36:03 +0100
Date: Tue, 7 Jan 2014 11:36:02 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Andrei Gherzan <andrei@gherzan.ro>, <bitbake-devel@lists.openembedded.org>
Message-ID: <20140107103602.GP31548@axis.com>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
MIME-Version: 1.0
In-Reply-To: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
User-Agent: Mutt/1.5.22 (2013-10-16)
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Fix _latest_revision function while using tags
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
X-List-Received-Date: Tue, 07 Jan 2014 10:36:08 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-01-05 02:53 +0100, Andrei Gherzan wrote:
> When getting the revision we must take into consideration if the name we are
> looking for is a tag and in that case we need the dereferenced commit ID in
> order to check for it existance in a specific branch.
> 
> So first search for the reference^{} commit ID and only if that returns nothing
> get the name as it is.

I think this is the same issue I've tried to solve in a patch i
sent in December (subject: bb.fetch2.git: support resolving both
tags and branches). I haven't heard anything about it yet though.

-- 
olofjn

