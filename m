Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1QWdKz-0006Ck-2B
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 Jun 2011 01:48:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Jun 2011 16:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,367,1304319600"; d="scan'208";a="13577463"
Received: from miles.jf.intel.com (HELO [10.7.199.94]) ([10.7.199.94])
	by orsmga002.jf.intel.com with ESMTP; 14 Jun 2011 16:44:34 -0700
Message-ID: <4DF7F261.6020007@intel.com>
Date: Tue, 14 Jun 2011 16:44:33 -0700
From: Scott Garman <scott.a.garman@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: Bitbake exception handling syntax.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 14 Jun 2011 23:48:01 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In a failed attempt to make bitbake pass the parsing stage with python 
v3, I noticed that the syntax we use for exception handling is 
inconsistent.

The old way is to do: except ExcType, localvar
The new way is: except ExcType as localvar

We're using the new syntax (which is python v3.x compatible) throughout 
most of the code, so the patch I'm about to submit cleans up the 
remaining cases using the old syntax.

Scott

-- 
Scott Garman
Embedded Linux Engineer - Yocto Project
Intel Open Source Technology Center


