Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <joshua.lock@intel.com>)
	id 1R9gtx-0007c6-Kl; Fri, 30 Sep 2011 19:29:33 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 30 Sep 2011 10:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,468,1312182000"; d="scan'208";a="72896574"
Received: from unknown (HELO [10.255.15.62]) ([10.255.15.62])
	by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2011 10:24:01 -0700
From: Joshua Lock <joshua.lock@intel.com>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Date: Fri, 30 Sep 2011 10:23:56 -0700
In-Reply-To: <CAEsOVNdwudRO7V2DQhpESC=xCqDtJqxJ72+e_hYDLq7bE=z+cg@mail.gmail.com>
References: <4E85D3E0.7070807@intel.com>
	<CAEsOVNdwudRO7V2DQhpESC=xCqDtJqxJ72+e_hYDLq7bE=z+cg@mail.gmail.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1317403442.11645.17.camel@scimitar>
Mime-Version: 1.0
X-Mailman-Approved-At: Fri, 30 Sep 2011 23:43:24 +0200
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Fri, 30 Sep 2011 17:29:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-30 at 10:20 -0600, McClintock Matthew-B29882 wrote:
> On Fri, Sep 30, 2011 at 9:36 AM, Yu Ke <ke.yu@intel.com> wrote:
> > Hi,
> >
> > As you may already know, a new GUI has been added to bitbake recently, i.e.
> > HOB (Human Oriented Builder). It is a graphical image creator that allows
> > user to freely choose which packages to be built in the image. The wiki
> > https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more detail.
> >
> > This email is to collect your feedback on the HOB. Current HOB is our first
> > version, and it surely has many place to improve. We has the plan to enhance
> > it in Yocto 1.2. So we really hope that you can use it and provide your
> > valuable feedback . We do think user's feedback/requirement is the right way
> > to go. Looking forward your valuable input.
> >
> > Best Regards
> > Ke
> >
> > Ps. The simple way to run hob is:
> > # touch conf/hob-pre.conf conf/hob-post.conf
> > # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
> >
> > Where conf/hob-pre.conf conf/hob-post.conf is the configuration file, which
> > can be empty in above case.
> 
> Has any discussion gone into making some sort of plugin or extensions?
> I'd like for it to be as easy as possible for someone new to make hob
> be able to some things like: configure runtime services, configure
> networking settings, add users, and I'm sure there are other things.

No such discussion has occurred. These are good feature suggestions,
though I'm not sure about a plugin mechanism - are you suggesting that
to enable the features mentioned or in addition to?
At least for enabling runtime services there's likely an issue of the
GUI having enough knowledge of the init system to do so.

I can certainly see at least the three features proposed here being
desirable and I'll probably file those as feature enhancements in the
bugzilla, unless you'd like to?

Any further thoughts on customisations to enable via the GUI?

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



