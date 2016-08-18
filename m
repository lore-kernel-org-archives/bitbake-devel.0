Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4AF6D77026
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 17:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7IH3wDI017022; Thu, 18 Aug 2016 18:03:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2MbnCFDqCWcH; Thu, 18 Aug 2016 18:03:58 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7IH3rnj017018
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2016 18:03:54 +0100
Message-ID: <1471539833.16712.19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 18:03:53 +0100
In-Reply-To: <1471539354-32382-2-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1471539354-32382-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/4] bitbake-selftest: utilize unittest.main better
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
X-List-Received-Date: Thu, 18 Aug 2016 17:04:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-08-18 at 19:55 +0300, Markus Lehtonen wrote:
> This simplifies the script, and, gives new features. It is now
> possible
> to run single test functions, for example. This is nice when writing
> new
> test cases.
> 
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>  bin/bitbake-selftest | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
> index 1e6f35e..1e615cc 100755
> --- a/bin/bitbake-selftest
> +++ b/bin/bitbake-selftest
> @@ -25,31 +25,17 @@ try:
>  except RuntimeError as exc:
>      sys.exit(str(exc))
>  
> -def usage():
> -    print('usage: [BB_SKIP_NETTESTS=yes] %s [-v] [testname1
> [testname2]...]' % os.path.basename(sys.argv[0]))

Could we at least preserve the usage message which is helpful as I can
never remember BB_SKIP_NETTESTS=yes without prompting...

Cheers,

Richard

