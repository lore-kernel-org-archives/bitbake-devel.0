Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9B14C76104
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GLAtR9012224; Wed, 16 Sep 2015 22:10:55 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gN6Mh6ogGhdo; Wed, 16 Sep 2015 22:10:55 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GLAgr2012215
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 16 Sep 2015 22:10:53 +0100
Message-ID: <1442437842.26666.179.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: brian avery <avery.brian@gmail.com>
Date: Wed, 16 Sep 2015 22:10:42 +0100
In-Reply-To: <fa4a3965a75c8b3c659d7bdce1f5949a2f6f046b.1441904599.git.avery.brian@gmail.com>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
	<fa4a3965a75c8b3c659d7bdce1f5949a2f6f046b.1441904599.git.avery.brian@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/5] toaster: Add tests for /project/X/builds page
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
X-List-Received-Date: Wed, 16 Sep 2015 21:10:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-09-10 at 10:05 -0700, brian avery wrote:
> From: Elliot Smith <elliot.smith@intel.com>
> 
> Add tests to check whether "in progress" builds are filtered
> out correctly, and that only builds for the current project
> are shown.
> 
> Adds a dependency on BeautifulSoup 4, which is used to simplify
> writing tests which verify the HTML.
> 
> Also requires a fix to how a date was converted in the view
> which only manifested when I wrote the tests.
> 
> [YOCTO #8236]
> [YOCTO #8187]
> 
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>

Could you rebase this patch and point me at a branch please. I can't
seem to get it to apply cleanly. I did get the others to work with line
offset warnings.

Cheers,

Richard


