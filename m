Received: from vms173015pub.verizon.net ([206.46.173.15])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1S8dbG-0006JH-Bi
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 21:18:10 +0100
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
	by vms173015.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M0Z00MXORU7GR91@vms173015.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 14:08:42 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id AFEE12016D; Fri,
	16 Mar 2012 15:08:31 -0400 (EDT)
Date: Fri, 16 Mar 2012 15:08:31 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Message-id: <20120316190831.GA21763@denix.org>
References: <4F6373BE.3040209@mvista.com>
MIME-version: 1.0
In-reply-to: <4F6373BE.3040209@mvista.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Conflict between BBCLASSEXTEND and named recipes.
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
X-List-Received-Date: Fri, 16 Mar 2012 20:18:10 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Fri, Mar 16, 2012 at 10:09:18AM -0700, Jeremy Puhlman wrote:
> There seems to be a bug with available providers when a recipe file
> provides the same name as an extended recipe. The extended version of
> the recipe does not seem to be available at all.
> 
> Example:
> 
> If zlib_1.2.6.bb exists in a layer, with BBCLASSEXTEND="native
> zlib-nativesdk" defined, and zlib-native_1.2.5.bb exists, the version
> 1.2.6 of zlib-native is not selectable at all.
> 
> 
> bitbake -s | grep zlib
> zlib                                                :1.2.6-r0
> zlib-native                                         :1.2.5-r0
> zlib-nativesdk                                      :1.2.6-r0
> 
> Even with PREFERRED_PROVIDER_zlib-naitve = 1.2.6 the results are the
> same. I have been poking around the parser, but really haven't made any
> progress, figured I would poke the list.

I don't have a solution, but I can confirm that this was a known issue all the 
way back when BBCLASSEXTEND got introduced in Classic OE. The workaround was 
to remove or mask the actual *-native.bb recipes.

-- 
Denys


