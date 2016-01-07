Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 913956B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jan 2016 14:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07E0AjP027644; Thu, 7 Jan 2016 14:00:10 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7MrtNOk_cm3G; Thu,  7 Jan 2016 14:00:10 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07E080o027639
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Jan 2016 14:00:10 GMT
Message-ID: <1452175208.7598.120.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>, Ross Burton
	<ross.burton@intel.com>
Date: Thu, 07 Jan 2016 14:00:08 +0000
In-Reply-To: <CABcZANnO9qiA0-7+tcz8Y03pa5gNEb4EcdKa1MQ6O_hkjgLsvA@mail.gmail.com>
References: <1452097500-18426-1-git-send-email-ross.burton@intel.com>
	<CABcZANnO9qiA0-7+tcz8Y03pa5gNEb4EcdKa1MQ6O_hkjgLsvA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH][RFC] bitbake-worker: set the process name when starting a task
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
X-List-Received-Date: Thu, 07 Jan 2016 14:00:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-01-06 at 14:42 -0700, Christopher Larson wrote:
> On Wed, Jan 6, 2016 at 9:25 AM, Ross Burton <ross.burton@intel.com>
> wrote:
> > If the setproctitle module is present then use it to change the
> > process name
> > when the worker starts a task.  This results in each worker showing
> > what task it
> > is executing in a process listing.
> > 
> > Signed-off-by: Ross Burton <ross.burton@intel.com>
> > 
> Very nice. Do you know if it's overwriting just the process name or
> the entire commandline? I'm wondering if pkill bitbake-worker would
> do what you want, or if you'd still need to use pkill -f, for
> example. I'd like to see the toplevel bitbake processes named nicely
> without the python path and whatnot too eventually. We could also
> name the parallel parsing processes (though admittedly they're not
> long lived). Perhaps this should go into a helper function in
> bb.utils or bb.process?

There is a slightly more ugly version of this we could use:

def set_process_title(name):
    from ctypes import cdll, byref, create_string_buffer
    libc = cdll.LoadLibrary('libc.so.6')
    buff = create_string_buffer(len(name)+1)
    buff.value = name
    libc.prctl(15, byref(buff), 0, 0, 0)

which would then mean we don't have a dependency on the external
module. Obviously using ctypes is a bit nasty though.

I would like to see this markup the worker/cooker/UI threads and so
on...

Cheers,

Richard

