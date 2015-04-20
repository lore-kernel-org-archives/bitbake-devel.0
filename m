Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 34CBC738F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 22:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3KM3Rbn032202; Mon, 20 Apr 2015 23:03:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A0_48R4-hQOH; Mon, 20 Apr 2015 23:03:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3KM3GOX032185
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 20 Apr 2015 23:03:27 +0100
Message-ID: <1429567396.26983.52.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 20 Apr 2015 23:03:16 +0100
In-Reply-To: <1429533121-32709-1-git-send-email-alexandru.damian@intel.com>
References: <1429533121-32709-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.26 1/1] setup.py update for 1.26 release
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
X-List-Received-Date: Mon, 20 Apr 2015 22:03:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-04-20 at 13:32 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> This patch updates setup.py and MANIFEST.in so it correctly
> packages bitbake in standard python package format.
> 
> Use "python manage.py sdist" to generate installation package.
> 
> Minor updates to toaster scripts so they work correctly
> from a package installation.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  MANIFEST.in                         | 207 ++++++++++++++++++++++++++++++++++--
>  bin/toaster                         |  31 ++++--
>  lib/toaster/toastermain/settings.py |   4 -
>  lib/toaster/toastermain/urls.py     |   3 -
>  setup.py                            |  16 +--
>  5 files changed, 232 insertions(+), 29 deletions(-)

We've been nervous about encouraging distros to ship packaged versions
of bitbake for some time. Things usually work better with the version
for the metadata you're using, not some random distro provided version.
We have been bitten by this a lot in the past. That said, we do have the
setup.py file and people do use it :/.

My other concern is the dependencies and the structure of this
packaging. I don't think bundling bitbake and toaster together is the
best move, I'd be much happier to see them packaged separately since
bitbake can happily be used without django, gobject and its other
dependencies.

I also noticed that ply and progressbar were dropped as requirements.
Whilst we ship copies of these with bitbake for simplicity, it was
previously a conscious decision not to package them and rely on the
upstream packaged version of them for the packaged version of bitbake.

Cheers,

Richard


