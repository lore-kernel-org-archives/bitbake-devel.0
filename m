Return-Path: <adrian.ambrozewicz@linux.intel.com>
X-Greylist: delayed 427 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 21 Jan 2020 09:44:06 UTC
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id D1A597FD7F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 09:44:06 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Jan 2020 01:37:00 -0800
X-IronPort-AV: E=Sophos;i="5.70,345,1574150400"; d="scan'208";a="215478068"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	21 Jan 2020 01:36:59 -0800
To: Bitbake-Devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
Date: Tue, 21 Jan 2020 10:36:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.3.1
MIME-Version: 1.0
Subject: devtool hardcodes using 'git' patchtool which causes errors
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
X-List-Received-Date: Tue, 21 Jan 2020 09:44:08 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

In poky sources i can see that default PATCHTOOL used is 'quilt' 
(https://github.com/openembedded/openembedded-core/blob/master/meta/conf/bitbake.conf) 
and it works flawlessly. Devtool however still defaults to legacy 'git' 
PATCHTOOL, as specified here:
http://git.yoctoproject.org/cgit.cgi/poky/plain/scripts/lib/devtool/standard.py
  > f.write('PATCHTOOL = "git"\n')

Request:
I've tried to debug the problem but I'm not very familiar with Bitbake 
code, so I wonder if we could default to 'quilt' for devtool as well?

Rationale:
'git' PATCHER doesn't work well when he have nested WORKDIR and 
striplevel used. 'bitbake -c patch [pkg]' works fine, but 'devtool 
modify [pkg]' fails with weird behavior. For example - new files created 
by patches are created in wrong location (WORKDIR instead of nested 
directory) and package doesn't compile until manually fixed.

Regards,
Adrian

