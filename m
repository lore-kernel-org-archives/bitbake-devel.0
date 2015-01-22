Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2F6CD72C16
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 14:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0MEvWG9020058; Thu, 22 Jan 2015 14:57:32 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZTdGLznFG5rU; Thu, 22 Jan 2015 14:57:32 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0MEvJfc020046
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Jan 2015 14:57:30 GMT
Message-ID: <1421938639.19798.17.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Jan 2015 14:57:19 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: Lifecycle issues in Bitbake
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
X-List-Received-Date: Thu, 22 Jan 2015 14:57:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Looking at and thinking about:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=5187

We have several issues. Firstly, DATE and TIME are locked in stone when
the base configuration is parsed. This may cause images to overwrite
previous versions for example if DATE and TIME are not re-evaluated. We
could fix this by specifically setting DATE and TIME in bitbake at
BuildStart?

Secondly, there is one cooker log file opened for the duration of the
cooker lifecycle. This is a cooker log, not a log of each build so that
is perhaps not surprising (and is the core problem in the above bug).
There is no overwriting of the log file, it just keeps growing with each
build.

We could trigger knotty to write out build specific log files based on
the BuildStart/Finish events?

Any thoughts on this?

Cheers,

Richard




