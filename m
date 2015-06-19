Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3950E6AC1E;
	Fri, 19 Jun 2015 08:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5J8OuR7007121; Fri, 19 Jun 2015 09:24:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Led-dAC2NCUQ; Fri, 19 Jun 2015 09:24:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5J8OelL006970
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2015 09:24:52 +0100
Message-ID: <1434702280.14710.104.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Fri, 19 Jun 2015 09:24:40 +0100
In-Reply-To: <55837D86.3060005@windriver.com>
References: <1434637048.14710.99.camel@linuxfoundation.org>
	<55837D86.3060005@windriver.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [RFC PATCH] data_smart: Drop expand parameter default
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
X-List-Received-Date: Fri, 19 Jun 2015 08:25:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-06-19 at 10:25 +0800, Robert Yang wrote:
> 
> On 06/18/2015 10:17 PM, Richard Purdie wrote:
> > Rather than just d.getVar(X), force the use of the more explict d.getVar(X, False)
> > since at some point in the future, having the default of expansion would
> > be nice. This is the first step towards that.
> 
> Did you mean that in the future:
> 
> d.getVar("PN") equals d.getVar("PN", True) ?
> 
> That would be great since expand=True uses more frequently
> than False.

The idea would be to get there, yes. How quickly we could do it is a
good question but this would be the first step.

Cheers,

Richard


