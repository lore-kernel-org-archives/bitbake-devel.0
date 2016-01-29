Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CCC9C77208
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 17:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0TH9Ye5005003; Fri, 29 Jan 2016 17:09:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YFq-QGAZs-y5; Fri, 29 Jan 2016 17:09:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0TH9VXu004999
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 29 Jan 2016 17:09:33 GMT
Message-ID: <1454087371.10340.73.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 29 Jan 2016 17:09:31 +0000
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 0/6] Improve caching task file dependency checksum caching
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
X-List-Received-Date: Fri, 29 Jan 2016 17:09:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-01-26 at 15:34 +0200, Markus Lehtonen wrote:
> This patchset improves the caching of task file dependency checksums in two
> ways. First, the patchset enables writing of the cache onto disk so that the
> checksums can be re-used on subsequent runs of bitbake. Previously the task
> signature checksums were calculated and cached in memory but never really
> saved.
> 
> Second, this patchset makes the task file dependency checksum cache file
> configurable. This is intended to be used e.g. with a further patchset for
> oe-core that will utilize task file dependencies heavily.
> 
> [YOCTO #8853]

Before I'd take this, I'd like to understand what this code does with a
large codebase, for example a kernel source tree.

I'd really like some performance measurements for the file counts
involved and the time it takes to stat trees like that. What is the
command overhead in that fairly pathological case?

Would we be better off requiring memory resident bitbake and using
inotify watches for example?

Cheers,

Richard

