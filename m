Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DCBB460132
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Oct 2016 12:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u9FCUh3O008465; Sat, 15 Oct 2016 13:30:43 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iJutju0uVA0S; Sat, 15 Oct 2016 13:30:43 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u9FCUZPj008449
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 15 Oct 2016 13:30:41 +0100
Message-ID: <1476534634.3671.0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linux.intel.com>,
	ed.bartosh@linux.intel.com
Date: Sat, 15 Oct 2016 13:30:34 +0100
In-Reply-To: <5800FD6F.2080103@linux.intel.com>
References: <1476400294-17333-1-git-send-email-anibal.limon@linux.intel.com>
	<20161014084408.GA392@linux.intel.com>
	<5800FD6F.2080103@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, brian.avery@intel.com,
	benjamin.esquivel@intel.com
Subject: Re: [PATCH] bb.event: fix infinite loop on print_ui_queue
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
X-List-Received-Date: Sat, 15 Oct 2016 12:30:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2016-10-14 at 10:44 -0500, Aníbal Limón wrote:
> On 10/14/2016 03:44 AM, Ed Bartosh wrote:
> > On Thu, Oct 13, 2016 at 06:11:34PM -0500, Aníbal Limón wrote:
> > > Would using full slice of ui_queue work the same way?
> Yes it will work and is more simple, i'll send v2.

Much nicer, thanks!

Cheers,

Richard

