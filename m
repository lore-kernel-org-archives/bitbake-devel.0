Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 915846093A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 13:12:39 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w11DCcwW000410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 1 Feb 2018 13:12:39 GMT
Message-ID: <1517490758.3090.44.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nathan Rossi <nathan@nathanrossi.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 01 Feb 2018 13:12:38 +0000
In-Reply-To: <20180131150728.20962-1-nathan@nathanrossi.com>
References: <20180131150728.20962-1-nathan@nathanrossi.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] fetch2: Handle missing donestamp file when content is valid
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
X-List-Received-Date: Thu, 01 Feb 2018 13:12:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-02-01 at 01:07 +1000, Nathan Rossi wrote:
> In order to allow users to manually populate the download directory
> with
> valid content change the assumption that missing the donestamp file
> means unfetched content.
> 
> This allows users to populate the download dir without needing to
> create
> dummy .done files such that a user does not need a PREMIRROR when
> using
> BB_NO_NETWORK to provide valid content files in the download
> directory.
> 
> Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
> ---
>  lib/bb/fetch2/__init__.py | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Could I persuade you into adding a test of this in
lib/bb/tests/fetch.py?

The advantage is that then we hopefully don't break this again!

Cheers,

Richard


