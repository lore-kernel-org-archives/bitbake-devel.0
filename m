Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BE8E67881D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Feb 2018 11:19:16 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w12BJFtN003857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 2 Feb 2018 11:19:16 GMT
Message-ID: <1517570355.3090.58.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 02 Feb 2018 11:19:15 +0000
In-Reply-To: <83c30f41462e2f78738b61f7beaf32411949fd7a.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
	<83c30f41462e2f78738b61f7beaf32411949fd7a.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 7/8] bitbake: cooker: fix event notifications
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
X-List-Received-Date: Fri, 02 Feb 2018 11:19:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-02-01 at 23:15 +0800, Robert Yang wrote:
> There are two kinds of events:
> * directory
>   We always need handle the event since we don't know what inside the
>   directory, for example:
>   $ bitbake --server-only -T -1
>   $ bitbake -p
>   $ mkdir ${TOPDIR}/classes
>   $ cp /path/to/base.bbclass classes
> 
>   The "${TOPDIR}/classes" is a new directory, the event only reports
> that the
>   directory is created, we don't know there is a base.bbclass unless
> the parser
>   runs.
> 
> * file:
>   Use bb.parse.supports() to check whether bitbake supports it or
> not.
> 
> And now the bbwatchedfiles is not needed anymore.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/cooker.py | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)

I'm not sure you can do this. For example, bitbake itself doesn't
know/care about *.patch files, however if one is referenced in a
SRC_URI and ends up on the watch list, would this change break a patch
file changing causing task checksums to change?

Its looking like we need better tests for some of this code too :/.

Cheers,

Richard


