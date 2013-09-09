Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4D0AA61117
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 15:30:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r89FhWWV012912; Mon, 9 Sep 2013 16:43:32 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yDXdhvMKNFpb; Mon,  9 Sep 2013 16:43:32 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r89FhRd0012888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 9 Sep 2013 16:43:29 +0100
Message-ID: <1378740589.3484.123.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 09 Sep 2013 16:29:49 +0100
In-Reply-To: <38a257cf48a0e83f75352c5f3eff36c305b48d09.1378129369.git.liezhi.yang@windriver.com>
References: <cover.1378129369.git.liezhi.yang@windriver.com>
	<38a257cf48a0e83f75352c5f3eff36c305b48d09.1378129369.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] runqueue.py: check whether multiple versions of the same PN are due to be built
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
X-List-Received-Date: Mon, 09 Sep 2013 15:30:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-02 at 09:47 -0400, Robert Yang wrote:
> There would be an race issue if we:
> 
> $ bitbake make-3.81 make-3.82
> 
> This because they are being built at the same time which would cause
> unexpected problems, for example:
> 
> [snip]
> ERROR: Package already staged (/path/to/tmp/sstate-control/manifest-qemux86-make.populate-sysroot)?!
> ERROR: Function failed: sstate_task_postfunc
> [snip]
> 
> Or there would be python's strack trace such as:
> 
> [snip]
>  *** 0004:    mfile = open(manifest)
>      0005:    entries = mfile.readlines()
>      0006:    mfile.close()
>      0007:
>      0008:    for entry in entries:
> Exception: IOError: [Errno 2] No such file or directory: xxx
> [snip]
> 
> [YOCTO #5094]
> 
> I think that we can quite earlier to fix the problem.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

I've merged this although I did move the code and change the error
message wording a little so the output is less confusing to the user.

Cheers,

Richard


