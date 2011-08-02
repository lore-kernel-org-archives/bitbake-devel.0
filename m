Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QoFMS-0001yf-BL; Tue, 02 Aug 2011 15:50:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p72Dk1H6015757;
	Tue, 2 Aug 2011 14:46:01 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14658-10; Tue,  2 Aug 2011 14:45:57 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p72DjqbO015751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Aug 2011 14:45:52 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
In-Reply-To: <201108021226.34560.paul.eggleton@linux.intel.com>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
Date: Tue, 02 Aug 2011 14:45:35 +0100
Message-ID: <1312292735.2344.597.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Tue, 02 Aug 2011 13:50:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-02 at 12:26 +0100, Paul Eggleton wrote:
> Hi all,
> 
> Andrea pointed out a situation where he has seen the layer priority overriding 
> version selection, and I've been able to confirm it.
> 
> Basically, if you have a recipe with a lower version in a layer with a higher 
> priority it selects the lower version. What's more after digging further I 
> found there were some rather anomalous interactions with the version logic and 
> BBCLASSEXTEND. Here's an example using Poky:
> 
> 1. Firstly, copy meta/recipes-support/curl to meta-yocto/recipes-support, then 
> rename the version in meta-yocto so that its version is 7.20.0. At this point 
> both meta/ and meta-yocto/ have the same layer priority of 5.
> 
> 2.  "bitbake -s | grep ^curl" reports:
> curl                                               :7.21.7-r0                          
> curl-native                                        :7.21.7-r0                          
> curl-nativesdk                                     :7.21.7-r0                          
> 
> 3. Now increase the layer priority in meta-yocto/conf/layer.conf to 6, and run  
> "bitbake -s | grep ^curl" again:
> curl                                               :7.20.0-r0                          
> curl-native                                        :7.21.7-r0                          
> curl-nativesdk                                     :7.21.7-r0                          

This is clearly broken and needs to be consistent at the very least.

> So the latest version here is a lie, this is not the latest version available. 
> Furthermore it seems not to have affected the BBCLASSEXTENDs.
> 
> 4. Now add PREFERRED_VERSION_curl = "7.21.7" to conf/layer.conf and run 
> "bitbake -s | grep ^curl" again:
> curl                                 :7.20.0-r0                :7.21.7-r0
> curl-native                    :7.21.7-r0                          
> curl-nativesdk               :7.21.7-r0                          
> 
> So it can clearly see the other recipe, it just doesn't acknowledge it until 
> you force the matter.
> 
> This is all rather undesirable behaviour IMHO - even if the BBCLASSEXTEND and 
> reported "latest version available" issues were corrected, I think the policy 
> of "latest version wins unless DEFAULT_PREFERENCE or PREFERRED_VERSION says 
> otherwise" should not be affected by layer priority.
> 
> Thoughts?

We could do with clearly documenting this in the bitbake manual. I
suspect users would expect the highest version to win and we probably
should change the behaviour but I'm open to other opinions.

Cheers,

Richard




