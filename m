Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QoDCd-0004Rq-AV
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 13:32:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 02 Aug 2011 04:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,305,1309762800"; d="scan'208";a="34217675"
Received: from unknown (HELO helios.localnet) ([10.255.18.59])
	by azsmga001.ch.intel.com with ESMTP; 02 Aug 2011 04:26:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: openembedded-core@lists.openembedded.org
Date: Tue, 2 Aug 2011 12:26:34 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
MIME-Version: 1.0
Message-Id: <201108021226.34560.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Layer priorities influencing default version selection
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
X-List-Received-Date: Tue, 02 Aug 2011 11:32:03 -0000
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

Andrea pointed out a situation where he has seen the layer priority overriding 
version selection, and I've been able to confirm it.

Basically, if you have a recipe with a lower version in a layer with a higher 
priority it selects the lower version. What's more after digging further I 
found there were some rather anomalous interactions with the version logic and 
BBCLASSEXTEND. Here's an example using Poky:

1. Firstly, copy meta/recipes-support/curl to meta-yocto/recipes-support, then 
rename the version in meta-yocto so that its version is 7.20.0. At this point 
both meta/ and meta-yocto/ have the same layer priority of 5.

2.  "bitbake -s | grep ^curl" reports:
curl                                               :7.21.7-r0                          
curl-native                                        :7.21.7-r0                          
curl-nativesdk                                     :7.21.7-r0                          

3. Now increase the layer priority in meta-yocto/conf/layer.conf to 6, and run  
"bitbake -s | grep ^curl" again:
curl                                               :7.20.0-r0                          
curl-native                                        :7.21.7-r0                          
curl-nativesdk                                     :7.21.7-r0                          

So the latest version here is a lie, this is not the latest version available. 
Furthermore it seems not to have affected the BBCLASSEXTENDs.

4. Now add PREFERRED_VERSION_curl = "7.21.7" to conf/layer.conf and run 
"bitbake -s | grep ^curl" again:
curl                                 :7.20.0-r0                :7.21.7-r0
curl-native                    :7.21.7-r0                          
curl-nativesdk               :7.21.7-r0                          

So it can clearly see the other recipe, it just doesn't acknowledge it until 
you force the matter.

This is all rather undesirable behaviour IMHO - even if the BBCLASSEXTEND and 
reported "latest version available" issues were corrected, I think the policy 
of "latest version wins unless DEFAULT_PREFERENCE or PREFERRED_VERSION says 
otherwise" should not be affected by layer priority.

Thoughts?

Cheers,
Paul

(PS: this is not unique to Poky, Andrea and I first reproduced this with 
Angstrom using bitbake master.)

-- 

Paul Eggleton
Intel Open Source Technology Centre


