Return-Path: <ross.burton@intel.com>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by mail.openembedded.org (Postfix) with ESMTP id D4FD07FA15
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jan 2020 13:54:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Jan 2020 05:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; d="scan'208";a="213706420"
Received: from jmmarti7-mobl1.amr.corp.intel.com (HELO rburton-mac01.local)
	([10.252.51.74])
	by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 05:54:37 -0800
To: frazer.clews@codethink.co.uk, bitbake-devel@lists.openembedded.org
References: <20200114144303.163316-1-frazer.clews@codethink.co.uk>
From: Ross Burton <ross.burton@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
	Swindon SN3 1RJ
Message-ID: <632ec1f6-e6a7-de3d-8f09-192e0541ce56@intel.com>
Date: Wed, 15 Jan 2020 13:54:36 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114144303.163316-1-frazer.clews@codethink.co.uk>
Subject: Re: [PATCH] lib: remove unused imports
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
X-List-Received-Date: Wed, 15 Jan 2020 13:54:38 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

You went too far:

Traceback (most recent call last):
   File "/home/ross/Yocto/poky/bitbake/bin/bitbake", line 19, in <module>
     import bb
   File "/home/ross/Yocto/poky/bitbake/lib/bb/__init__.py", line 74, in 
<module>
     import bb.msg
   File "/home/ross/Yocto/poky/bitbake/lib/bb/msg.py", line 18, in <module>
     import bb.event
   File "/home/ross/Yocto/poky/bitbake/lib/bb/event.py", line 23, in 
<module>
     import bb.exceptions
   File "/home/ross/Yocto/poky/bitbake/lib/bb/exceptions.py", line 10, 
in <module>
     class TracebackEntry(namedtuple.abc):
AttributeError: 'function' object has no attribute 'abc'

Ross

