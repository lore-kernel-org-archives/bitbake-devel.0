Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E0358602D9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 May 2016 09:04:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 25 May 2016 02:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,363,1459839600"; d="scan'208";a="961915609"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga001.jf.intel.com with ESMTP; 25 May 2016 02:04:48 -0700
Message-ID: <1464167087.941.8.camel@linux.intel.com>
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 12:04:47 +0300
In-Reply-To: <35bff996-f13e-f7d3-4a85-ec710cbc61f8@linux.intel.com>
References: <1464074730-23187-1-git-send-email-markus.lehtonen@linux.intel.com>
	<35bff996-f13e-f7d3-4a85-ec710cbc61f8@linux.intel.com>
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Subject: Re: [PATCH] cookerdata: print an error if layer dir does not exist
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
X-List-Received-Date: Wed, 25 May 2016 09:04:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Leonardo,

On Tue, 2016-05-24 at 09:09 -0500, Leonardo Sandoval wrote:
> 
> On 05/24/2016 02:25 AM, Markus Lehtonen wrote:
> > Makes it easier for user to identify problems, e.g. typos, in
> > BBLAYERS.
> > 
> > [YOCTO #9507]
> > 
> > Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> > ---
> >   lib/bb/cookerdata.py | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> > index 1615db5..7dfe7b5 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -292,6 +292,10 @@ class CookerDataBuilder(object):
> >               data = bb.data.createCopy(data)
> >               approved = bb.utils.approved_variables()
> >               for layer in layers:
> > +                if not os.path.isdir(layer):
> > +                    parselog.critical("Layer directory '%s' does
> > not to exist! "
> > +                                      "Please check BBLAYERS in
> > %s" % (layer, layerconf))
> > +                    sys.exit(1)
> 
> Markus, I am not familiar with this code, but instead of a
> sys.exit(1), 
> would it be better to raise a exception instead (raise
> SystemExit(msg))?
> 
> >                   parselog.debug(2, "Adding layer %s", layer)
> >                   if 'HOME' in approved and '~' in layer:
> >                       layer = os.path.expanduser(layer)
> 

The reason for this is that with SystemExit() the output will be much
uglier. Bitbake will not only print the error message but also all
logging debug messages and I think that this may confuse the user. The
output would look something like:
--- SNIP -----------------------------------------------------
Layer directory '#' does not to exist! Please check BBLAYERS in
/home/marquiz/yocto/openembedded-core/build-9507/conf/bblayers.conf
DEBUG: Removed the following variables from the environment: _,
LS_COLORS, EMAIL, JAVA_ROOT, LESS, G_BROKEN_FILENAMES, MINICOM,
CSHEDIT, HOSTTYPE, LESSOPEN, QT_SYSTEM_DIR, PYTHONSTARTUP, CVS_RSH,
GPG_AGENT_INFO, INPUTRC, XDG_VTNR, SOCKS_PROXY, CPU, QT_IM_SWITCHER,
XSESSION_IS_UP, AUDIODRIVER, LESSKEY, XDG_DATA_DIRS, XNLSPATH,
TERMINATOR_UUID, ALSA_CONFIG_PATH, HISTSIZE, SDL_AUDIODRIVER, WINDOWID,
LESS_ADVANCED_PREPROCESSOR, gopher_proxy, MANPATH, XMODIFIERS,
WINDOWPATH, JAVA_HOME, PROFILEREAD, XKEYSYMDB, VDPAU_DRIVER,
GIT_CEILING_DIRECTORIES, JAVA_BINDIR, XDG_RUNTIME_DIR, DISPLAY,
PYTHONPATH, COMP_WORDBREAKS, NNTPSERVER, XCURSOR_THEME,
DBUS_SESSION_BUS_PID, G_FILENAME_ENCODING, OSTYPE, HOST, FROM_HEADER,
LESSCLOSE, JRE_HOME, socks_proxy, LS_OPTIONS, GPG_TTY, XDG_SESSION_ID,
DBUS_SESSION_BUS_ADDRESS, ORBIT_SOCKETDIR, LANG, GTK_IM_MODULE,
CONFIG_SITE, XDG_CONFIG_DIRS, GTK_MODULES, SOCKS5_SERVER, XDG_SEAT,
OLDPWD, HOSTNAME, WINDOWMANAGER, INPUT_METHOD, SHLVL, QT_IM_MODULE,
COLORTERM, BUILDDIR, QEMU_AUDIO_DRV, MAIL, MACHTYPE, PAGER,
XAUTHLOCALHOSTNAME, MORE
DEBUG: Found bblayers.conf (/home/marquiz/yocto/openembedded-core/build
-9507/conf/bblayers.conf)
DEBUG: Adding layer /home/marquiz/yocto/openembedded-core/meta
--- SNIP -----------------------------------------------------


The reason for this behavior is that bitbake will spit out all log messages (even debug messages) if it exits at this early stage and there are no non-debug messages in the logger.


Thanks,
  Markus




