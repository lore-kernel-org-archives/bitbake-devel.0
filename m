Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9991177B5B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 19:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490730652; x=1522266652;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=JzVrGbCK1T+r9FXWIvmZkNIDFqrVmdN1R4sQjbyd04Y=;
	b=T/jOFLCfjXtnVl1Gs/hpnfqOFJWrI+AEneZQXq+WhuDp8SoejxHTXeQf
	jjnzxwYvTJmDBXfxmKAbI8I67FoZEw==;
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Mar 2017 12:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,238,1486454400"; 
	d="py'?scan'208";a="839413394"
Received: from dalin-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.138.23])
	by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2017 12:50:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Christopher Larson <chris_larson@mentor.com>
Date: Wed, 29 Mar 2017 08:50:46 +1300
Message-ID: <4811829.bIhWvhHDll@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <CABcZANnahbPL5bLobQ8TTQu=+UmdyHpmi8u7wbduZFSkcQzBgQ@mail.gmail.com>
References: <cover.1490662146.git.paul.eggleton@linux.intel.com>
	<93968aed34753e90e05945b2bce34ccfb4743a60.1490662146.git.paul.eggleton@linux.intel.com>
	<CABcZANnahbPL5bLobQ8TTQu=+UmdyHpmi8u7wbduZFSkcQzBgQ@mail.gmail.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] lib/bb/codeparser: ensure BufferedLogger respects target filtering
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
X-List-Received-Date: Tue, 28 Mar 2017 19:50:52 -0000
X-Groupsio-MsgNum: 8517
Content-Type: multipart/mixed; boundary="nextPart4238051.qs5SfqrDQ1"
Content-Transfer-Encoding: 7Bit

--nextPart4238051.qs5SfqrDQ1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 29 March 2017 5:01:31 AM NZDT Christopher Larson wrote:
> On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton <
> paul.eggleton@linux.intel.com> wrote:
> > BufferedLogger was sending log records to the target logger using
> > handle() - this meant that the filtering (e.g. log level set)
> > on the target logger was bypassed, leading for example to debug records
> > getting printed when the log level was set to logging.WARNING.
> >=20
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
>=20
> The =E2=80=98filter=E2=80=99 method of a Logger instance doesn=E2=80=99t =
log anything, it=E2=80=99s a
> subclass of Filterer, which just checks whether it should be logged. The
> =E2=80=98handle=E2=80=99 method of a Logger already consults self.filter(=
), if you check
> the code:
>=20
>    def handle(self, record):
>           """
>           Call the handlers for the specified record.
>=20
>           This method is used for unpickled records received from a socke=
t,
> as
>           well as those created locally. Logger-level filtering is applie=
d.
>           """
>           if (not self.disabled) and self.filter(record):
>               self.callHandlers(record)

Oops, you're right. I'm still confused about why I'm seeing debugging messa=
ges=20
when the target logger is set to INFO then. Do you have any suggestions on =
how=20
we fix this?

(I've attached a simplified test script demonstrating the issue.)

Cheers,
Paul

=2D-=20

Paul Eggleton
Intel Open Source Technology Centre

--nextPart4238051.qs5SfqrDQ1
Content-Disposition: attachment; filename="testlogging.py"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-python; charset="UTF-8"; name="testlogging.py"

import logging
import sys
import os


def logger_create(name, stream=None):
    logger = logging.getLogger(name)
    loggerhandler = logging.StreamHandler(stream=stream)
    formatter = logging.Formatter("%(levelname)s: %(message)s")
    loggerhandler.setFormatter(formatter)
    logger.addHandler(loggerhandler)
    logger.setLevel(logging.INFO)
    return logger

Logger = logging.getLoggerClass()
class BufferedLogger(Logger):
    def __init__(self, name, level=0, target=None):
        Logger.__init__(self, name)
        self.setLevel(level)
        self.buffer = []
        self.target = target

    def handle(self, record):
        self.buffer.append(record)

    def flush(self):
        for record in self.buffer:
            self.target.handle(record)
        self.buffer = []


logger = logger_create('mylogger')
logger.setLevel(logging.INFO)

buflogger = BufferedLogger('mylogger.Data.PythonParser', logging.DEBUG, logger)
buflogger.debug('buffered debug')

logger.debug('hello debug')
logger.info('hello info')
logger.warn('hello warning')
logger.error('hello error')

buflogger.flush()

--nextPart4238051.qs5SfqrDQ1--
