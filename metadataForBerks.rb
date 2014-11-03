name "stem_premier"

depends 'mongodb'
depends 'elasticsearch'

provides 'deployCookbooks'
provides 'deployCookbooks::deploy'
provides 'deployCookbooks::fastDeploy'
provides 'deployCookbooks::setup'
provides 'deployCookbooks::twitDeploy'
provides 'deployCookbooks::twitSetup'