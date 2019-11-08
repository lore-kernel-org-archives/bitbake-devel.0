Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9B9D47FC41
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2019 14:08:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Nov 2019 06:08:36 -0800
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; d="scan'208";a="196909194"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	08 Nov 2019 06:08:35 -0800
To: Bitbake-Devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
Date: Fri, 8 Nov 2019 15:08:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
Subject: Patch idea - fetcher for gerrit patches
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
X-List-Received-Date: Fri, 08 Nov 2019 14:08:35 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hello,

As it is my first message here allow me to introduce myself. I'm Adrian 
Ambrożewicz and I work at Intel Technology Poland. I love flexibility 
and features of Bitbake and I would like to propose new feature which 
will solve our problem.

I would like to propose extension to already supported fetcher library - 
gerrit. Idea is to be able to apply gerrit patches by simply specifying: 
"SRC_URI += gerrit://[gerrit_server];change=[change_id]". Fetcher would 
then take care of downloading most recent patchset from given review.
Further extensiosn of that fetcher could include ability to specify:
- revision (get given revision instead of top)
- topic (get all patches from given topic)
- project (to be used in conjunction with 'topic' parameter)
etc...

I've prepared minimal PoC implementation without any error handling. It 
works just fine and is basing on wget command. Gerrit REST API is used 
to obtain base64-encoded patch which is then decoded to file with name 
[change_id].patch . I'm very interested in polishing that and 
upstreaming it for everyone to use.

The question I have for you is the following: does this fetcher have a 
chance to be accepted upstream?

Regards,
Adrian

