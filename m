Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 98E15783DC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Sep 2017 10:41:40 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v8CAfaOQ006603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 12 Sep 2017 11:41:38 +0100
Message-ID: <1505212896.18640.17.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 12 Sep 2017 11:41:36 +0100
In-Reply-To: <2d7f1ec85c8242b1348597e7963b962efe562070.1505210965.git.paul.eggleton@linux.intel.com>
References: <cover.1505210965.git.paul.eggleton@linux.intel.com>
	<2d7f1ec85c8242b1348597e7963b962efe562070.1505210965.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 1/1] command: Add command to invalidate parse cache
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
X-List-Received-Date: Tue, 12 Sep 2017 10:41:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-09-12 at 22:10 +1200, Paul Eggleton wrote:
> If we make a change to the metadata within a tinfoil-using script
> and then attempt to run tasks using build_targets(), the change won't
> get noticed. Add an explicit command that will set the internal flag
> to
> force reloading the cache and thus pick up the changes. This will be
> used in OE by the devtool source extraction rework.
> 
> Part of the fix for [YOCTO #11198].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  lib/bb/command.py | 3 +++
>  1 file changed, 3 insertions(+)

Just a quick sanity check. Why won't the change get noticed? Any file
writes should be seen by the inotify code which would invalidate the
cache? This could mean we're not watching some dependency we should be?
or is it that the commands aren't triggering a reparse due to ordering
somehow? I'd like to understand this more before we add this...

Cheers,

Richard

