Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C9B3A606BF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 05:44:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u6Q5iEmq027654
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 25 Jul 2016 22:44:14 -0700 (PDT)
Received: from [128.224.162.240] (128.224.162.240) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.248.2;
	Mon, 25 Jul 2016 22:44:13 -0700
To: Ross Burton <ross.burton@intel.com>, <bitbake-devel@lists.openembedded.org>
References: <1469485946-6370-1-git-send-email-ross.burton@intel.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <5796F8AC.9050309@windriver.com>
Date: Tue, 26 Jul 2016 13:44:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1469485946-6370-1-git-send-email-ross.burton@intel.com>
Subject: Re: [PATCH] lib/bb/build: handle incomplete message fragments in log FIFO
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
X-List-Received-Date: Tue, 26 Jul 2016 05:44:15 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


I tested this patch, didn't see the "Unrecognised command" any more.

// Robert

On 07/26/2016 06:32 AM, Ross Burton wrote:
> It's possible that the logging FIFO doesn't do a complete read (or the sender a
> complete write) with the result that an incomplete message is read in bitbake.
> This used to result in silently truncated lines but since 42d727 now also
> results in a warning as the start of the rest of the message isn't a valid
> logging command.
>
> Solve this by storing incoming bytes in a bytearray() across reads, and parsing
> complete messages from that.
>
> [ YOCTO #9999 ]
>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>   bitbake/lib/bb/build.py | 67 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index a4deb00..c632a27 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -385,39 +385,44 @@ exit $ret
>           else:
>               bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
>
> +    fifobuffer = bytearray()
>       def readfifo(data):
> -        lines = data.split(b'\0')
> -        for line in lines:
> -            # Just skip empty commands
> -            if not line:
> -                continue
> -            splitval = line.split(b' ', 1)
> -            cmd = splitval[0].decode("utf-8")
> -            if len(splitval) > 1:
> -                value = splitval[1].decode("utf-8")
> -            else:
> -                value = ''
> -            if cmd == 'bbplain':
> -                bb.plain(value)
> -            elif cmd == 'bbnote':
> -                bb.note(value)
> -            elif cmd == 'bbwarn':
> -                bb.warn(value)
> -            elif cmd == 'bberror':
> -                bb.error(value)
> -            elif cmd == 'bbfatal':
> -                # The caller will call exit themselves, so bb.error() is
> -                # what we want here rather than bb.fatal()
> -                bb.error(value)
> -            elif cmd == 'bbfatal_log':
> -                bb.error(value, forcelog=True)
> -            elif cmd == 'bbdebug':
> -                splitval = value.split(' ', 1)
> -                level = int(splitval[0])
> -                value = splitval[1]
> -                bb.debug(level, value)
> +        nonlocal fifobuffer
> +        fifobuffer.extend(data)
> +        while fifobuffer:
> +            message, token, nextmsg = fifobuffer.partition(b"\00")
> +            if token:
> +                splitval = message.split(b' ', 1)
> +                cmd = splitval[0].decode("utf-8")
> +                if len(splitval) > 1:
> +                    value = splitval[1].decode("utf-8")
> +                else:
> +                    value = ''
> +                if cmd == 'bbplain':
> +                    bb.plain(value)
> +                elif cmd == 'bbnote':
> +                    bb.note(value)
> +                elif cmd == 'bbwarn':
> +                    bb.warn(value)
> +                elif cmd == 'bberror':
> +                    bb.error(value)
> +                elif cmd == 'bbfatal':
> +                    # The caller will call exit themselves, so bb.error() is
> +                    # what we want here rather than bb.fatal()
> +                    bb.error(value)
> +                elif cmd == 'bbfatal_log':
> +                    bb.error(value, forcelog=True)
> +                elif cmd == 'bbdebug':
> +                    splitval = value.split(' ', 1)
> +                    level = int(splitval[0])
> +                    value = splitval[1]
> +                    bb.debug(level, value)
> +                else:
> +                    bb.warn("Unrecognised command '%s' on FIFO" % cmd)
> +                fifobuffer = nextmsg
>               else:
> -                bb.warn("Unrecognised command '%s' on FIFO" % cmd)
> +                break
> +
>       tempdir = d.getVar('T', True)
>       fifopath = os.path.join(tempdir, 'fifo.%s' % os.getpid())
>       if os.path.exists(fifopath):
>

