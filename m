Received: from hermes.mlbassoc.com ([64.234.241.98] helo=mail.chez-thomas.org)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gary@mlbassoc.com>) id 1R9lFR-0005LI-6x
	for bitbake-devel@lists.openembedded.org;
	Sat, 01 Oct 2011 00:08:01 +0200
Received: by mail.chez-thomas.org (Postfix, from userid 999)
	id 4694C16601DB; Fri, 30 Sep 2011 15:55:53 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from hermes.chez-thomas.org (localhost.localdomain [127.0.0.1])
	by mail.chez-thomas.org (Postfix) with ESMTP id 7659316601AC;
	Fri, 30 Sep 2011 15:55:52 -0600 (MDT)
Message-ID: <4E863AE8.7020901@mlbassoc.com>
Date: Fri, 30 Sep 2011 15:55:52 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
MIME-Version: 1.0
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
References: <4E85D3E0.7070807@intel.com>
In-Reply-To: <4E85D3E0.7070807@intel.com>
X-Mailman-Approved-At: Wed, 05 Oct 2011 15:27:42 +0200
Cc: Joshua <joshua.lock@intel.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Fri, 30 Sep 2011 22:08:01 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-09-30 08:36, Yu Ke wrote:
> Hi,
>
> As you may already know, a new GUI has been added to bitbake recently, i.e. HOB (Human Oriented Builder). It is a graphical image creator that allows user to freely choose which
> packages to be built in the image. The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob has more detail.
>
> This email is to collect your feedback on the HOB. Current HOB is our first version, and it surely has many place to improve. We has the plan to enhance it in Yocto 1.2. So we
> really hope that you can use it and provide your valuable feedback . We do think user's feedback/requirement is the right way to go. Looking forward your valuable input.
>
> Best Regards
> Ke
>
> Ps. The simple way to run hob is:
> # touch conf/hob-pre.conf conf/hob-post.conf
> # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
>
> Where conf/hob-pre.conf conf/hob-post.conf is the configuration file, which can be empty in above case.

I build images which are not based on any of the core-XXX images listed by HOB.
How can I get them into the drop-down base list?
Is there a way I can filter out some of the base images?  tasks?

I ask these questions because in particular, I use a lot of the recipes in meta
and meta-yocto, but none of the images or tasks (because they don't really address
my needs, don't take offense, I just want more control than they offer)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


