Return-Path: <Konrad.Scherer@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 982B67FBAD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 20:39:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x9PKdcqJ000610
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 13:39:38 -0700
Received: from [128.224.21.229] (128.224.21.229) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0;
	Fri, 25 Oct 2019 13:39:37 -0700
To: <bitbake-devel@lists.openembedded.org>
From: Konrad Scherer <Konrad.Scherer@windriver.com>
Message-ID: <f49f3c55-72d8-a781-955d-8f257a42615d@windriver.com>
Date: Fri, 25 Oct 2019 16:39:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
X-Originating-IP: [128.224.21.229]
Subject: Using gitsm fetcher and PREMIRROR
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
X-List-Received-Date: Fri, 25 Oct 2019 20:39:37 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello,

I recently found a strange problem involving the gitsm fetcher and our PREMIRRORS and I was able to 
reproduce it using poky.

 > git clone git://git.yoctoproject.org/poky poky1
 > cd poky1
 > . oe-init-build-env
 > bitbake ovmf

The ovmf recipe has git submodules inside git submodules. This step works fine.

I then exposed the downloads directory over http (http://<host>/downloads) and the downloads/git2 
directory over http with git-http-backend enabled (http://<host>/git).

I noticed that there are shallow clone tarballs in downloads that match the git repos in 
downloads/git2. For example:

downloads/git2/boringssl.googlesource.com.boringssl/
downloads/git2_boringssl.googlesource.com.boringssl.tar.gz

Since these are duplicates of the git repos, I deleted the tar.gz files

 > rm -f downloads/git2_*

<new shell>

 > git clone git://git.yoctoproject.org/poky poky2
 > cd poky2
 > . oe-init-build-env
 > cat >> conf/local.conf <<EOF
WRS_MIRROR_HOST = "<host>"
BB_ALLOWED_NETWORKS = "${WRS_MIRROR_HOST}"

BB_NO_NETWORK = '0'
BB_FETCH_PREMIRRORONLY = '1'

PREMIRRORS_append = " \
      .*://.*/.* http://${WRS_MIRROR_HOST}/downloads/ \n \
      git://.*/.* git://${WRS_MIRROR_HOST}/git/MIRRORNAME;protocol=http \n \
      gitsm://.*/.* git://${WRS_MIRROR_HOST}/git/MIRRORNAME;protocol=http \n \
"
CONNECTIVITY_CHECK_URIS = ""
EOF
 > bitbake ovmf

This fails with:

ERROR: ovmf-edk2-stable201905-r0 do_unpack: gitsm: submodule unpack failed: UnpackError Unpack 
failure for URL: 
'gitsm://github.com/openssl/openssl;protocol=https;name=CryptoPkg/Library/OpensslLib/openssl;subpath=CryptoPkg/Library/OpensslLib/openssl;bareclone=1;nobranch=1'. 
No up to date source found: clone directory not available or not up to date: 
/ala-lpggp22/kscherer/gitsm/poky2/build/downloads/git2/github.com.openssl.openssl; shallow clone not 
enabled

If I leave the shallow clone tarballs in the PREMIRROR the build succeeds. The other recipes that 
use git are fetched properly. The logs don't have any warnings before the error and I verified that 
the objects are indeed present in the repo.

Are my PREMIRROR settings correct? Is this a bug in the gitsm fetcher?

Any help and insight appreciated.

-- 
Konrad Scherer, MTS, Linux Products Group, Wind River

