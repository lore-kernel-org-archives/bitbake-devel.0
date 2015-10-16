Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7F41F77168
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 16:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9GG04l3023510; Fri, 16 Oct 2015 17:00:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LOwOYcAmbU11; Fri, 16 Oct 2015 17:00:04 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9GFxqHe023452
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Oct 2015 17:00:03 +0100
Message-ID: <1445011191.17974.34.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Smith, Elliot" <elliot.smith@intel.com>
Date: Fri, 16 Oct 2015 16:59:51 +0100
In-Reply-To: <CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Fri, 16 Oct 2015 16:00:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-10-16 at 16:57 +0100, Smith, Elliot wrote:
> Thanks for these, Richard.
>
> On 11 October 2015 at 10:22, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         The console log data is written to is created at console
>         initialisation
>         time and does not change over reset events. This ensures the
>         BB_CONSOLELOG value is correct over such resets by preserving
>         it.
>
> I've put your three patches on top of master and ran a few builds. The
> result is that all of the logs for those builds are going into a
> single timestamped file. Before, they went to separate files. Is this
> intentional, or was the old behaviour incorrect? (Ideally, toaster
> needs a separate log file for each build.)
> 
It should generate one log file for each "session". A session would be
one logfile for all bitbake memory resident transactions and a log file
for each commandline transaction.

It is a "console log", not an individual build log.

Cheers,

Richard




