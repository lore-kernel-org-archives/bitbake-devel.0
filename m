Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 152D760962;
	Fri,  5 Jun 2015 12:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t55CEmXo016131; Fri, 5 Jun 2015 13:14:48 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yGxI9a5BuwvX; Fri,  5 Jun 2015 13:14:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t55CEWAu016107
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 5 Jun 2015 13:14:43 +0100
Message-ID: <1433506472.19831.18.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 05 Jun 2015 13:14:32 +0100
In-Reply-To: <1432766602.404.90.camel@linuxfoundation.org>
References: <1432766602.404.90.camel@linuxfoundation.org>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: RFC: update_data removal
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
X-List-Received-Date: Fri, 05 Jun 2015 12:14:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2015-05-27 at 23:43 +0100, Richard Purdie wrote:
> I've been experimenting with this and I do have a branch which basically
> works:
> 
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rpurdie/noupdatedata5

Testing showed up some issues. I've addressed those and this code is now
as a bitbake branch at:

http://git.openembedded.org/bitbake/log/?h=noupdatedata

This now builds ok on the autobuilder. There is a small issue with
bitbake-selftest, I've a patch pending to address that (its a minor
tweak).

I've also sent a few patches to OE-Core to address issues these changes
showed up which I believe are omissions in the metadata.

Cheers,

Richard


