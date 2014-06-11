Return-Path: <Wenlin.Kang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 960066B232
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 08:24:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s5B8OSZu016294
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 01:24:28 -0700 (PDT)
Received: from [128.224.162.182] (128.224.162.182) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.169.1;
	Wed, 11 Jun 2014 01:24:27 -0700
Message-ID: <5398120C.7040001@windriver.com>
Date: Wed, 11 Jun 2014 16:23:40 +0800
From: Wenlin Kang <wenlin.kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1402455340-29531-1-git-send-email-wenlin.kang@windriver.com>
In-Reply-To: <1402455340-29531-1-git-send-email-wenlin.kang@windriver.com>
X-Originating-IP: [128.224.162.182]
Subject: Re: [PATCH] fetch2/svn.py: fix Unable to fetch URL bug
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
X-List-Received-Date: Wed, 11 Jun 2014 08:24:36 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 2014年06月11日 10:55, Wenlin Kang wrote:
> The testing steps and instructions:
>
> First, we need to create a svn server on the server side, eg, my is svnroot
> $svnadmin create ~/workspace/svnroot
>
> Second, on the client side:
> $mkdir -p ~/workspace/svntest
> $cd ~/workspace/svntest
> $mkdir -p test/{trunk,branches,tag}
> $mkdir -p test/trunk/tdir0/tdir1/tdir2
> $touch test/trunk/hello.c
> $touch test/trunk/tdir0/tdir1/tdir2/test2.c
> $touch test/trunk/tdir0/tdir1/test1.c
> $touch test/trunk/tdir0/test0.c
>
> $svn import -m "create the project test" test/ svn://xxx.xxx.xxx.xxx/svnroot/test
>
> Then, make some commit,...
> Such, we now get "r15"
>
> $svn cp -m "create a branch test_debug-1.0" svn://xxx.xxx.xxx.xxx/svnroot/test/trunk svn://xxx.xxx.xxx.xxx/svnroot/test/branches/test_debug-1.0
>
> Now, we need to create a bb file(eg,mytest.bb) to download "tdir1" with the verion < test_debug-1.0 created time version,
> eg, download r12, then in bb file has:
>
> SRCREV = "12"
> SRC_URI = "svn://xxx.xxx.xxx.xxx/svnroot/test/branches/test_debug-1.0;module=test0/tdir1"

Replace "module=test0/tdir1" with "module=tdir0/tdir1"

//Wenlin

> Last, run fetch for mytest.bb
>
> Wenlin Kang (1):
>    fetch2/svn.py: fix Unable to fetch URL bug
>
>   lib/bb/fetch2/svn.py |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>


-- 
Thanks,
Wenlin Kang


