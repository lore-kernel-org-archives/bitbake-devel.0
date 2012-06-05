Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SbtGw-0006gL-VU
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 14:54:07 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Jun 2012 05:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="108027647"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Jun 2012 05:43:40 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 5 Jun 2012 05:43:39 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.56]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.90]) with mapi id
	14.01.0355.002; Tue, 5 Jun 2012 20:43:37 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Lv, XiaotongX" <xiaotongx.lv@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] Webhob: Clean up the code and
	modify	some errors
Thread-Index: AQHNQwHlLlxjS2Pt1Eau6ckNwb5J0Zbrq2Jg
Date: Tue, 5 Jun 2012 12:43:36 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BCA8D0@SHSMSX102.ccr.corp.intel.com>
References: <cover.1338969711.git.xiaotongx.lv@intel.com>
	<a37743c622fceab340dd090228f978074d85239d.1338969711.git.xiaotongx.lv@intel.com>
In-Reply-To: <a37743c622fceab340dd090228f978074d85239d.1338969711.git.xiaotongx.lv@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Webhob: Clean up the code and modify	some errors
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
X-List-Received-Date: Tue, 05 Jun 2012 12:54:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I hope this patch can be merged into your first patch (the base patch), whi=
ch is missing.

--
Shane

Xiaotong lv wrote on=A02012-06-06:

> Signed-off-by: Xiaotong Lv <xiaotongx.lv@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py |   20 ++++---
>  bitbake/lib/bb/ui/webhob_webservice.py             |   53
>  ++++++++----------- 2 files changed, 33 insertions(+), 40 deletions(-)
> diff --git a/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py
> b/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py index
> dc6f316..eaa8729 100644 ---
> a/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py +++
> b/bitbake/lib/bb/ui/crumbs/webserviceeventhandler.py @@ -27,12 +27,14 @@
> class WSEventHandler:
>          if self.ret_value:
>              self.ret_value =3D {}
> -    def event_model_to_jsondata(self, data):
> +    #To convert the list in recipe and packages tree model into string t=
ype.
> +    #so that the tree model can be converted into standard json data
> +    def treemodel_list_tostring(self, data):
>          for k, v in data.iteritems():
>              if isinstance(v, dict):
> -                data[k] =3D self.event_model_to_jsondata(v)
> +                data[k] =3D self.treemodel_list_tostring(v)
>              elif isinstance(v, list):
> -                data[k] =3D " ".join(v)
> +                data[k] =3D ' '.join(v)
>              else:
>                  data[k] =3D v
>          return data
> @@ -45,12 +47,12 @@ class WSEventHandler:
>=20
>          if isinstance(event, bb.event.PackageInfo):
>              self.ret_value["event"] =3D bb.event.getName(event)
> -            self.ret_value["pkginfolist"] =3D
> self.event_model_to_jsondata(event._pkginfolist) +          =20
> self.ret_value["pkginfolist"] =3D
> self.treemodel_list_tostring(event._pkginfolist)
>          elif isinstance(event, bb.event.SanityCheckPassed):
>              self.ret_value["event"] =3D bb.event.getName(event)
>          #Handler these logs, do we need to do some logging filtering
> under logging.INFO level.
> -        #cause maybe some logging are unuseful but this can affect the
> webservice efficiency
> +        #cause maybe some loggings are unuseful but this can affect the
> webservice efficiency.
>          #and client user experience
>          elif isinstance(event, logging.LogRecord):
>                  self.ret_value["event"] =3D bb.event.getName(event)
> @@ -63,7 +65,7 @@ class WSEventHandler:
>          elif isinstance(event, bb.event.TargetsTreeGenerated):
>              self.ret_value["event"] =3D bb.event.getName(event)
>              if event._model:
> -                self.ret_value["model"] =3D
> self.event_model_to_jsondata(event._model) +              =20
> self.ret_value["model"] =3D self.treemodel_list_tostring(event._model)
>=20
>          elif isinstance(event, bb.event.ConfigFilesFound):
>              self.ret_value["event"] =3D bb.event.getName(event)
> @@ -121,7 +123,7 @@ class WSEventHandler:
>=20
>          elif isinstance(event, bb.event.MultipleProviders):
>              self.ret_value["event"] =3D bb.event.getName(event)
> -            self.ret_value["candidates"] =3D ", ".join(event._candidates=
)
> +            self.ret_value["candidates"] =3D ' '.join(event._candidates)
>              self.ret_value["runtime"] =3D event._runtime
>              self.ret_value["item"] =3D event._item
> @@ -166,7 +168,7 @@ class WSEventHandler:
>              self.ret_value["taskid"] =3D event.taskid
>              self.ret_value["stats"] =3D {'completed':event.stats.complet=
ed,
>                                         'active':event.stats.active,
> -                                       'active':event.stats.failed
> +                                       'failed':event.stats.failed
>                                         }
>              self.ret_value["pid"] =3D event.pid
> @@ -185,4 +187,4 @@ class WSEventHandler:
>              self.ret_value["taskstring"] =3D event.taskstring
>              self.ret_value["pid"] =3D event.pid
> -        return self.ret_value \ No newline at end of file +      =20
> return self.ret_value diff --git
> a/bitbake/lib/bb/ui/webhob_webservice.py
> b/bitbake/lib/bb/ui/webhob_webservice.py index c4544e1..1dd474a 100755
> --- a/bitbake/lib/bb/ui/webhob_webservice.py +++
> b/bitbake/lib/bb/ui/webhob_webservice.py @@ -51,7 +51,6 @@ class
> Param(ClassSerializer):
>      If a client to call runCommand() method, the following is param
>      format: param =3D {
>          'function'   =3D 'string' -        'param_num'  =3D 'int'
>          'param_type' =3D ['string','list','bool'] 'params'     =3D
>          ['str','str1 str2 str3...','true or false']
>      }
> @@ -59,7 +58,6 @@ class Param(ClassSerializer):
>=20
>      __namespace__ =3D "param" function =3D String -    param_num =3D Int=
eger
>      param_type =3D Array(String) params =3D Array(String)
> @@ -71,34 +69,27 @@ class WebServiceWrap(DefinitionBase):
>      def runCommand(self, param):
>          command =3D [] function =3D param.function -        param_num =
=3D
>          param.param_num param_type =3D param.param_type params =3D
>          param.params
> -        if param_num>0: -            if None in
> param.__dict__.values(): -               return "Fatal: function,
> param_num, param_type, params values cannot be None." - -            if
> len(params) !=3D param_num and len(params) !=3D param_num: -             =
 =20
> return "Fatal: param_type and params length should be equal to
> param_num" - +        if function:
>              command.append(function)
> -            for item in param_type: -               if item =3D=3D
> 'string': -                   command.append(params.pop(0)) -          =20
>    elif item =3D=3D 'bool': -                 =20
> command.append(bool(params.pop(0))) -               elif item =3D=3D 'lis=
t':
> -                  command.append(params.pop(0).split()) -             =20
> else: -                  command =3D [] -                  return "Fatal:
> only 'string', 'bool', 'list' should be in param_type" - -        if
> param_num =3D=3D 0 and param.function: -            command.append(functi=
on)
> - -        if not command: -            return "Fatal: function,
> param_num values cannot be None." +        else: +            return
> "Error: key(function) value cannot be required." + +        if
> param_type and params: +            if len(param_type) =3D=3D len(params)=
: +
>                for item in param_type: +                    if item =3D=
=3D
> 'string': +                        command.append(params.pop(0)) +     =20
>              elif item =3D=3D 'bool': +                      =20
> command.append(bool(params.pop(0))) +                    elif item =3D=3D
> 'list': +                       command.append(params.pop(0).split()) +=20
>                   else: +                       return "Error: only
> 'string', 'bool', 'list' should be in param_type" +            else: + =20
>              return "Error: key(param_type) value length should be equal
> to params"
>=20
>          ret =3D WebServiceWrap.server.runCommand(command)
>          return json.dumps(ret)
> @@ -124,10 +115,10 @@ def main (server =3D None, eventHandler =3D None):
>      port =3D 0
>      for i in sys.argv[1:]:
>          pattern =3D r'(\d+.\d+.\d+.\d+):(\d+)'
> -        if re.match(pattern, i):
> -            ip =3D i.split(':')
> -            host =3D ip[0]
> -            port =3D int(ip[1])
> +        match =3D re.match(pattern, i)
> +        if match:
> +            host =3D match.group(1)
> +            port =3D int(match.group(2))
>              break if not host and not port: sys.exit('Fatal: using
>              bitbake -u webhob_webservice
> ip:port\n')
> @@ -135,7 +126,7 @@ def main (server =3D None, eventHandler =3D None):
>      try:
>          from wsgiref.simple_server import make_server
>          server =3D make_server(host, port, Application([WebServiceWrap],
> 'tns'))
> -        print "Webservice UI runnning \nWSDL is at: http://%s:%s/?wsdl" =
%
> (host, port)
> +        print "Webservice UI runnning... \nWSDL is at:
> http://%s:%s/?wsdl" % (host, port)
 server.serve_forever() except ImportError: print "Fatal: webservice
 server code requires Python >=3D 2.5"




