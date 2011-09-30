Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>)
	id 1R9eHi-0002iM-TS; Fri, 30 Sep 2011 16:41:55 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 30 Sep 2011 07:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,467,1312182000"; d="scan'208";a="69056075"
Received: from kyu3-desk.ccr.corp.intel.com (HELO [10.238.154.176])
	([10.238.154.176])
	by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2011 07:36:16 -0700
Message-ID: <4E85D3E0.7070807@intel.com>
Date: Fri, 30 Sep 2011 22:36:16 +0800
From: Yu Ke <ke.yu@intel.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0) Gecko/20110922 Thunderbird/7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core <openembedded-core@lists.openembedded.org>,
	Lock, Joshua <joshua.lock@intel.com>
Subject: Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Fri, 30 Sep 2011 14:41:55 -0000
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

As you may already know, a new GUI has been added to bitbake recently, 
i.e. HOB (Human Oriented Builder). It is a graphical image creator that 
allows user to freely choose which packages to be built in the image. 
The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more 
detail.

This email is to collect your feedback on the HOB. Current HOB is our 
first version, and it surely has many place to improve. We has the plan 
to enhance it in Yocto 1.2. So we really hope that you can use it and 
provide your valuable feedback . We do think user's feedback/requirement 
is the right way to go. Looking forward your valuable input.

Best Regards
Ke

Ps. The simple way to run hob is:
# touch conf/hob-pre.conf conf/hob-post.conf
# bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf

Where conf/hob-pre.conf conf/hob-post.conf is the configuration file, 
which can be empty in above case.


