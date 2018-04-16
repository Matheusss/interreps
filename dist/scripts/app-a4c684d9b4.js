(function(){angular.module("interreps",["ngAnimate","ngCookies","ngTouch","ngSanitize","ngMessages","ngAria","ui.router","toastr","ui.bootstrap","ngStorage","checklist-model","ui.select","xeditable","akoenig.deckgrid","ngFileUpload"])}).call(this),function(){angular.module("interreps").controller("AdminRepsDetailsController",["$rootScope","$scope","$timeout","$interval","$filter","$state","$uibModalStack","rep",function(e,t,n,i,a,s,r,l){"ngInject";t.rep=l,t.methods={close:function(){return r.dismissAll()}}}])}.call(this),function(){angular.module("interreps").controller("AdminRepsCreateController",["$rootScope","$scope","$timeout","$interval","$filter","$state","$uibModalStack","FirebaseService",function(e,t,n,i,a,s,r,l){"ngInject";t.rep={},t.repsLength=l.getAllReps().length,t.methods={save:function(){return t.rep.id=t.repsLength+1,l.createRep(t.rep)},close:function(){return r.dismissAll()}}}])}.call(this),function(){}.call(this),function(){angular.module("interreps").controller("AdminScoresController",["$rootScope","$scope","$timeout","$interval","$filter","$state","FirebaseService","reps","competitions","allCompetitionsArray",function(e,t,n,i,a,s,r,l,o,c){"ngInject";t.reps=l,t.competitions=o,t.allCompetitionsArray=c,t.selectedReps=[],t.leaderboard=[],e.currentState=_.find(e.menu,function(e){return e.state===s.current.name}),_.each(t.reps,function(e){var n,i;return n=_.indexOf(t.reps,e),i={position:n+1,rep:""},t.leaderboard.push(i)}),t.methods={validateRepsAdded:function(e){return e?t.selectedReps.push(e):void 0},validateRepsRemoved:function(e,n,i){var a;return e.stopPropagation(),t.leaderboard[i].rep=void 0,a=t.selectedReps.indexOf(n),a>-1?t.selectedReps.splice(a,1):void 0}}}])}.call(this),function(){angular.module("interreps").controller("AdminSchedulesController",["$rootScope","$scope","$timeout","$interval","$state","FirebaseService",function(e,t,n,i,a,s){"ngInject";t.events=[],e.currentState=_.find(e.menu,function(e){return e.state===a.current.name}),t.events=[],t.config={calendar:{editable:!0,header:{left:"month agendaWeek agendaDay",center:"title",right:"today prev,next"}}},t.methods={addEvent:function(){return t.events.push({})}}}])}.call(this),function(){angular.module("interreps").controller("AdminRulesController",["$rootScope","$scope","$timeout","$interval","$state","FirebaseService","rules",function(e,t,n,i,a,s,r){"ngInject";t.rules=r,e.currentState=_.find(e.menu,function(e){return e.state===a.current.name}),t.methods={save:function(){return s.updateRules(t.rules)}}}])}.call(this),function(){angular.module("interreps").controller("AdminRepsController",["$rootScope","$scope","$timeout","$interval","$filter","$state","$uibModal",function(e,t,n,i,a,s,r){"ngInject";var l;l=firebase.storage(),t.reps=t.$parent.reps,t.repsSearched=angular.copy(t.reps),e.currentState=_.find(e.menu,function(e){return e.state===s.current.name}),_.map(t.reps,function(e){var t;return l.ref("logos/"+e.user+".jpg").getDownloadURL().then(function(t){return n(function(){return e.url=t,e})}),e.competitions?(t=_.find(e.competitions,function(e){return"Coringa"===e.name}),e.joker=t?t.team[0]:""):e.joker="-"}),_.map(t.repsSearched,function(e){var t;return l.ref("logos/"+e.user+".jpg").getDownloadURL().then(function(t){return n(function(){return e.url=t,e})}),e.competitions?(t=_.find(e.competitions,function(e){return"Coringa"===e.name}),e.joker=t?t.team[0]:""):e.joker="-"}),t.methods={getDetails:function(e){var t;return t=r.open({animation:!0,windowTemplateUrl:"window-template.html",templateUrl:"details.html",controller:"AdminRepsDetailsController",backdrop:"no",resolve:{rep:function(){return e}}})},createRep:function(){var e;return e=r.open({animation:!0,windowTemplateUrl:"window-template.html",templateUrl:"create.html",controller:"AdminRepsCreateController",backdrop:"no"})}},t.$watch("search",function(e,n){return""!==e&&(t.repsSearched=a("filter")(t.reps,{name:e})),""===e?t.repsSearched=angular.copy(t.reps):void 0})}])}.call(this),function(){angular.module("interreps").config(["$stateProvider","$urlRouterProvider",function(e,t){"ngInject";return e.state("register",{url:"/register/:id",params:{id:null},templateUrl:"app/register/template.html",controller:"RegisterController",controllerAs:"register",resolve:{rep:["FirebaseService","$stateParams",function(e,t){return e.getRepById(t.id)}],competitions:["FirebaseService",function(e){return e.getAllCompetitions()}],prices:["FirebaseService",function(e){return e.getPrices()}]}})}])}.call(this),function(){angular.module("interreps").controller("RegisterController",["$rootScope","$scope","$timeout","$interval","$localStorage","FirebaseService","rep","competitions","prices",function(e,t,n,i,a,s,r,l,o){"ngInject";t.rep=r,t.allCompetitions=l,t.prices=o,t.totalCost=t.rep.totalCost||0,t.selectedPrice={},t.img="../assets/images/"+t.rep.user+".jpg",t.selectedCompetitions=t.rep.competitions||[],t.user=a.user,t.participant={},t.participants=t.rep.participants||[],t.team={partitipants:[],competition:{}},t.teams=[],t.futebolPrices=["Futebol","Futebol + 1","Futebol + 2","Futebol + 3","Futebol + Queimada + 3 modalidades"],t.queimadaPrices=["Queimada","Queimada 1","Queimada 2","Queimada 3","Futebol + Queimada + 3 modalidades"],t.methods={addParticipant:function(){return t.participant!=={}?(t.participants.push(t.participant),t.participant={}):void 0},removeParticipant:function(e){return t.participants.splice(e,1)},clear:function(){return t.participants=[]},save:function(){return console.log(t.participants),s.updateRepParticipants(t.rep.id,t.participants),s.updateRepCompetitions(t.rep.id,t.selectedCompetitions),s.updateRepTotalCost(t.rep.id,t.totalCost)}},t.$watchCollection("selectedCompetitions",function(e,n){return t.totalCost=0,_.each(e,function(e){var n;return n=e.team?e.price*e.team.length:0*e.price,t.totalCost+=n})})}])}.call(this),function(){angular.module("interreps").service("HomeService",["$http","$q",function(e,t){return{}}])}.call(this),function(){angular.module("interreps").config(["$stateProvider","$urlRouterProvider",function(e,t){"ngInject";return e.state("home",{url:"/",templateUrl:"app/main/template.html",controller:"MainController",controllerAs:"main",resolve:{users:["FirebaseService",function(e){return e.getAllUsers()}],reps:["FirebaseService",function(e){return e.getAllReps()}]}}),t.otherwise("/")}])}.call(this),function(){angular.module("interreps").directive("ngBgSlideshow",["$interval",function(e){"ngInject";return{restrict:"A",scope:{ngBgSlideshow:"&",interval:"="},templateUrl:"app/components/bgCarousel/template.html",link:function(t,n,i){var a;return t.$watch("ngBgSlideshow",function(e){return t.images=e(),t.active_image=0}),a=e(function(){t.active_image++,t.active_image>=t.images.length&&(t.active_image=0)},t.interval||1e3)}}}]).controller("MainController",["$rootScope","$scope","$state","$timeout","$interval","$localStorage","FirebaseService","StorageService","users","reps",function(e,t,n,i,a,s,r,l,o,c){"ngInject";t.users=o,t.reps=c,t.$storage=s,t.showForm=!1,t.user={email:void 0,password:void 0,user:void 0},t.methods={changeView:function(){return t.showForm=!t.showForm},login:function(){var e,a;return l.deleteCurrentUser(),a=_.find(t.users,function(e){return e.user===t.user.user&&e.password===t.user.password}),e=_.find(t.reps,function(e){return e.user===t.user.user&&e.password===t.user.password}),a&&(t.$storage.user={type:"admin",user:a},l.setCurrentUser(a),i(function(){return n.go("admin.reps",{id:a.id})},1e3)),e?(t.$storage.user={type:"rep",user:e},l.setCurrentUser(e),i(function(){return n.go("register",{id:e.id})},1e3)):void 0}}}])}.call(this),function(){angular.module("interreps").config(["$stateProvider","$urlRouterProvider",function(e,t){"ngInject";return e.state("admin",{url:"/admin/:id","abstract":!0,params:{id:null},templateUrl:"app/admin/template.html",controller:"AdminController",resolve:{reps:["FirebaseService",function(e){return e.getAllReps()}],user:["FirebaseService","$stateParams",function(e,t){return e.getUserById(t.id)}]}}).state("admin.reps",{url:"/reps",templateUrl:"app/admin/reps/template.html",controller:"AdminRepsController"}).state("admin.schedules",{url:"/schedules",templateUrl:"app/admin/schedules/template.html",controller:"AdminSchedulesController"}).state("admin.scores",{url:"/scores",templateUrl:"app/admin/scores/template.html",controller:"AdminScoresController",resolve:{reps:["FirebaseService",function(e){return e.getAllReps()}],competitions:["FirebaseService",function(e){return e.getAllCompetitions()}],allCompetitionsArray:["FirebaseService",function(e){return e.getCompetitionsArray()}]}}).state("admin.rules",{url:"/rules",templateUrl:"app/admin/rules/template.html",controller:"AdminRulesController",resolve:{rules:["FirebaseService",function(e){return e.getRules()}]}})}])}.call(this),function(){angular.module("interreps").controller("AdminController",["$rootScope","$scope","$state","$timeout","$interval","user","reps",function(e,t,n,i,a,s,r){"ngInject";t.state=n,t.user=s,t.reps=r,t.status={isopen:!1},t.img="../assets/images/"+t.user.user+".png",e.menu=[{name:"Repúblicas",icon:"fas fa-users fa-lg",state:"admin.reps"},{name:"Horários",icon:"fas fa-clock fa-lg",state:"admin.schedules"},{name:"Placar",icon:"fas fa-trophy fa-lg",state:"admin.scores"},{name:"Regulamento",icon:"fas fa-exclamation-circle fa-lg",state:"admin.rules"}],e.currentState=_.find(e.menu,function(e){return e.state===t.state.current.name}),t.methods={}}])}.call(this),function(){angular.module("interreps").service("StorageService",["$http","$q","$localStorage","$rootScope",function(e,t,n,i){return{getCurrentUser:function(){return i.currentUser||n.user},setCurrentUser:function(e){return i.currentUser=e},deleteCurrentUser:function(){return i.currentUser=void 0}}}])}.call(this),function(){angular.module("interreps").run(["$log","$rootScope","$state","StorageService",function(e,t,n,i){"ngInject";return e.debug("runBlock end"),t.$on("$stateChangeStart",function(e,t,a,s,r,l){return console.log(i.getCurrentUser()),i.getCurrentUser()||""===s.name?void 0:n.go("home")})}])}.call(this),function(){angular.module("interreps").constant("MOMENT",moment).constant("ADMINS",["0hzjcgDnBLVByLbQ1ttkAzCShv92"])}.call(this),function(){angular.module("interreps").config(["$logProvider","toastrConfig",function(e,t){"ngInject";return e.debugEnabled(!0),t.allowHtml=!0,t.timeOut=3e3,t.positionClass="toast-top-right",t.preventDuplicates=!0,t.progressBar=!0}])}.call(this),function(){angular.module("interreps").service("FirebaseService",["$http","$q",function(e,t){var n,i;return i=firebase.database(),n=firebase.auth(),{getCurrentAuthuser:function(){return n.currentUser},getAllUsers:function(){return i.ref("users").once("value").then(function(e){return e.val()})},getUserById:function(e){var t;return e=parseInt(e),t=e-1,i.ref("users").child(t).once("value").then(function(e){return e.val()})},getAllReps:function(){return i.ref("reps").once("value").then(function(e){return e.val()})},getRepById:function(e){var t;return e=parseInt(e),t=e-1,i.ref("reps").child(t).once("value").then(function(e){return e.val()})},getRepCompetitions:function(e){var t;return e=parseInt(e),t=e-1,i.ref("reps").child("index").child("competitions").once("value").then(function(e){return e.val()})},updateRepCompetitions:function(e,t){var n;return e=parseInt(e),n=e-1,i.ref("reps").child(n).child("competitions").set(t)},updateRepParticipants:function(e,t){var n;return e=parseInt(e),n=e-1,i.ref("reps").child(n).child("participants").set(t)},updateRepTotalCost:function(e,t){var n;return e=parseInt(e),n=e-1,i.ref("reps").child(n).child("totalCost").set(t)},createRep:function(e){return i.ref("reps").once("value").then(function(t){var n,a;return a=t.val().length,n=i.ref("reps"),n.child("/"+a).set(e)})},getAllCompetitions:function(){return i.ref("competitions").once("value").then(function(e){return e.val()})},getCompetitionsArray:function(){return i.ref("allCompetitions").once("value").then(function(e){return e.val()})},updateLeaderboard:function(e,t){var n;return n=[],i.ref("reps").once("value").then(function(e){return n=e.val()}),i.ref("allCompetitions").once("value").then(function(a){var s;return s=_.findIndex(a.val(),function(t){return t.name===e}),i.ref("allCompetitions").child(s).child("leaderboard").set(t).then(function(a){return _.each(t,function(t){var a,s,r;return s=_.findIndex(n,function(e){return e.name===t.rep}),r=_.find(n,function(e){return e.name===t.rep}),a=_.findIndex(r.competitions,function(t){return t.name===e}),i.ref("reps").child(s).child("competitions").child(a).child("position").set(t.position)})})})},getRules:function(){return i.ref("rules").once("value").then(function(e){return e.val()})},updateRules:function(e){return i.ref("rules").set(e)},getPrices:function(){return i.ref("prices").once("value").then(function(e){return e.val()})}}}])}.call(this),angular.module("interreps").run(["$templateCache",function(e){e.put("app/admin/template.html",'<div class=admin><div class=navbar><div class=navbar-container><div class=aaauso-logo></div><div class=admin-menu><ul class=ul-options><li class=menu-name ng-class="{\'active\' : state.current.name === item.state}" ng-repeat="item in menu"><a ui-sref={{item.state}}><span><i class={{item.icon}}></i> <span class=name>{{item.name}}</span></span></a></li></ul><div class="btn-group ul-options-dropdown" uib-dropdown is-open=status.isopen uib-dropdown dropdown-append-to-body><button id=single-button type=button class="btn btn-outline" uib-dropdown-toggle>{{currentState.name}} <span class=caret></span></button><ul class=dropdown-menu uib-dropdown-menu role=menu aria-labelledby=single-button><li role=menuitem ng-repeat="item in menu" ng-class="{\'active\' : state.current.name === item.state}"><a ui-sref={{item.state}}>{{item.name}}</a></li></ul></div></div><div class=user-info><div class=rep-logo ng-style="{ \'background-image\': \'url(\' + img + \')\' }"></div><div class=rep-name><div class=rep-name-container><span class=name>{{user.name}}</span></div></div></div></div></div><div class=admin-layer><div class=admin-parent-container><div class=admin-container><div ui-view class=screen-height></div></div></div></div></div>'),e.put("app/main/template.html",'<div id=home><div class=home-container><div ng-bg-slideshow="[ \'/assets/images/interreps1.jpg\', \'/assets/images/interreps2.jpg\', \'/assets/images/interreps3.jpg\']" interval=5000></div><!-- <div class="image"></div> --></div><div class=home-container-layer><div class=home-center-container><div class=home-main><div class=home-main-container><div class=home-sentence><div class=home-divider><span>AAAUSO X</span></div></div><div class=home-content><div class=home-divider><div class=logo><!-- <h1>Atlética Unesp Sorocaba</h1> --><div class=logo-bg></div></div><div class=login><button type=button class="btn btn-outline login-button" ng-if=!showForm ng-click=methods.changeView()>Login</button><div class=login-container ng-if=showForm><span class=login-title>Login</span><form ng-submit=methods.login() class=login-form><div class=typeble><div class=login-typed-input><input type=text placeholder=Usuário class="email animated clean-padding-sides" ng-model=user.user required></div><div class=login-typed-input><input type=password placeholder=Senha class="password animated clean-padding-sides" ng-model=user.password required></div></div><div class=login-actions><button type=button ng-disabled="!user.user || !user.password" class="btn btn-login" ng-click=methods.login()>Login</button></div></form></div><div class=back-button><button type=button class="btn btn-outline" ng-if=showForm ng-click=methods.changeView()>Voltar</button></div></div></div></div></div></div></div></div></div>'),e.put("app/register/template.html",'<div class=register><div class=navbar><div class=navbar-container><div class=aaauso-logo></div><div class=user-info><div class=rep-logo ng-style="{ \'background-image\': \'url(\' + img + \')\' }"></div><div class=rep-name><div class=rep-name-container><span class=name>República {{user.name}}</span></div></div></div></div></div><div class=register-layer><div class=register-parent-container><div class=register-container><div class=register-title><h1>Inscrição (Custo total: R${{totalCost || 0}},00)</h1></div><div class=register-form><div class="col-md-6 names-form"><h3 class=register-title>Participantes</h3><form novalidate ng-submit=methods.addParticipant()><div class=register-input><label>Escreva o nome de cada participante e clique no botão ou pressione \'enter\' para adicioná-lo:</label><input type=text placeholder=Nome class="email animated clean-padding-sides" ng-model=participant.name required> <button class=icon-btn type=submit ng-click=methods.addParticipant><i class="add-participant fas fa-plus-circle fa-lg"></i></button></div></form><div class=participants><div ng-repeat="participant in participants track by $index"><span class="tag animated animated-fill"><span ng-if=::removeCallback class=tag-remove-btn ng-click=methods.remove(index)></span> <a>{{participant.name}}</a> <button class=icon-btn ng-click=methods.removeParticipant($index)><i class="fas fa-trash"></i></button></span></div></div></div><div class="col-md-6 competitions-form"><!-- <h3 class="register-title">Provas</h3>\n            <div class="section-info">\n              <label>Selecione o combo de prova(s) que desejam:</label>\n            </div> --><!-- <div class="col-md-12 no-padding">\n              <select name="comp-select" id="comp-select" ng-model="selectedPrice" ng-change="methods.changePrice()">\n                <option class="select-options" value="" disabled selected>Selecione</option>\n                <option class="select-options"  ng-repeat="item in prices" value={{item}}>{{item.name}} (R${{item.price}})</option>\n              </select>\n            </div> --><div><div class=section-info><label>Selecione as provas que desejam participar:</label></div><div class=col-md-4><label class=comp-type>Esportes</label><div class=checkboxes ng-repeat="sport in allCompetitions.sports track by $index"><label class="custom-checkboxes icon-btn"><input class=check type=checkbox data-checklist-model=selectedCompetitions data-checklist-value=sport checklist-comparator=.name> <i class="unchecked far fa-square fa-lg"></i> <i class="checked far fa-check-square fa-lg"></i> <span>{{sport.name}}</span></label></div></div><div class=col-md-4><label class=comp-type>Não alcóolicos</label><div class=checkboxes ng-repeat="comp in allCompetitions.nonAlcoholic.individual track by $index"><label class="custom-checkboxes icon-btn"><input class=check type=checkbox data-checklist-model=selectedCompetitions data-checklist-value=comp checklist-comparator=.name> <i class="unchecked far fa-square fa-lg"></i> <i class="checked far fa-check-square fa-lg"></i> <span>{{comp.name}}</span></label></div><div class=checkboxes ng-repeat="comp in allCompetitions.nonAlcoholic.team track by $index"><label class="custom-checkboxes icon-btn"><input class=check type=checkbox data-checklist-model=selectedCompetitions data-checklist-value=comp checklist-comparator=.name> <i class="unchecked far fa-square fa-lg"></i> <i class="checked far fa-check-square fa-lg"></i> <span>{{comp.name}}</span></label></div></div><div class=col-md-4><label class=comp-type>Alcóolicos</label><div class=checkboxes ng-repeat="comp in allCompetitions.alcoholic.individual track by $index"><label class="custom-checkboxes icon-btn"><input class=check type=checkbox data-checklist-model=selectedCompetitions data-checklist-value=comp checklist-comparator=.name> <i class="unchecked far fa-square fa-lg"></i> <i class="checked far fa-check-square fa-lg"></i> <span>{{comp.name}}</span></label></div><div class=checkboxes ng-repeat="comp in allCompetitions.alcoholic.team track by $index"><label class="custom-checkboxes icon-btn"><input class=check type=checkbox data-checklist-model=selectedCompetitions data-checklist-value=comp checklist-comparator=.name> <i class="unchecked far fa-square fa-lg"></i> <i class="checked far fa-check-square fa-lg"></i> <span>{{comp.name}}</span></label></div></div></div></div><div class=col-md-12><h3 class=register-title>Participantes X Provas</h3><label>Agora selecione o(s) participante(s) que irá(ão) competir cada prova:</label><div class=selects ng-repeat="comp in selectedCompetitions track by $index"><label>{{comp.name}} (max: {{comp.maxParticipants}})</label><ui-select ng-model=comp.team theme=bootstrap multiple limit={{comp.maxParticipants}}><ui-select-match><span ng-bind=$item></span></ui-select-match><ui-select-choices repeat="item in participants | filter: $select.search track by $index"><span ng-bind=item></span></ui-select-choices></ui-select></div></div><div class="row save-btn-row"><button type=button class="btn btn-outline" ng-click=methods.save()>Salvar</button></div></div></div></div></div></div>'),e.put("app/admin/reps/template.html",'<div class=admin-reps-container><div class=row><div class="col-xs-12 col-sm-8 col-md-9 col-lg-10"><div class=input-search><input type=text ng-model=search class=search placeholder=Pesquisar...></div></div><div class="col-xs-12 col-sm-4 col-md-3 col-lg-2" ng-style="{\'margin-top\': \'10px\'}"><span>{{reps.length}} repúblicas cadastradas</span></div></div><div class="row search-row"><div class="col-xs-12 col-sm-8 col-md-9 col-lg-10"></div><div class="col-xs-12 col-sm-4 offset-sm-8 col-md-3 offset-md-9 col-lg-2 offset-lg-12" ng-style="{\'margin-top\': \'10px\'}"><button type=button class="btn btn-outline" ng-click=methods.createRep()>Cadastrar nova rep</button></div></div><div class=row><div deckgrid source=repsSearched class=deckgrid><div class=card ng-click=mother.methods.getDetails(card)><div class=rep-logo ng-style="{ \'background-image\': \'url(\' + card.url + \')\' }"></div><div class=rep-fast-info><h2 class=name ng-bind=::card.name></h2><h6 class=status>Coringa: {{::card.joker}}</h6></div></div></div></div></div><!-- Details template --><script type=text/ng-template id=details.html><div id="modal-rep-details">\n    <div class="window-header">\n      <h1 class="window-description-header">República {{rep.name}}</h1>\n    </div>\n      <div class="window-content">\n        <table class="table table-striped rep-infos-table">\n          <thead>\n            <tr>\n              <th class="column-1">Provas</th>\n              <th class="column-2">Participantes</th>\n            </tr>\n          </thead>\n          <tbody>\n            <tr ng-if="rep.competitions.length" ng-repeat="comp in rep.competitions">\n              <td class="column-1">{{comp.name}}</td>\n              <td class="column-2">\n                <ul ng-repeat="part in comp.team">\n                  <li>\n                    - {{part}}\n                  </li>\n                </ul>\n              </td>\n            </tr>\n            <tr ng-if="!rep.competitions.length">\n              <td class="no-data-td">Nenhum dado encontrado.</td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n      <div class="window-footer">\n        <button type="button" class="btn-outline" ng-click="methods.close()">Fechar</button>\n      </div>\n    </form>\n  </div></script><!-- Create template --><script type=text/ng-template id=create.html><div id="modal-rep-create">\n    <div class="window-header">\n      <h1 class="window-description-header">Cadastrar nova república</h1>\n    </div>\n      <div class="window-content">\n        <form novalidade class="create-form">\n          <div class="row input-row">\n            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col">\n              <label>Nome:</label>\n              <input type="text" ng-model="rep.name" placeholder="Digite..."/>\n            </div>\n            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col">\n              <label>Email:</label>\n              <input type="text" ng-model="rep.email" placeholder="Digite..."/>\n            </div>\n          </div>\n          <div class="row input-row">\n            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col">\n              <label>Usúario:</label>\n              <input type="text" ng-model="rep.user" placeholder="Digite..."/>\n            </div>\n            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col">\n              <label>Senha:</label>\n              <input type="text" ng-model="rep.password" placeholder="Digite..."/>\n            </div>\n          </div>\n          <div class="row input-row-button">\n            <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">\n              <button type="button" class="btn btn-outline" ng-click="methods.save()">Salvar</button>\n            </div>\n          </div>\n        </form>\n      </div>\n      <div class="window-footer">\n        <button type="button" class="btn-outline" ng-click="methods.close()">Fechar</button>\n      </div>\n    </form>\n  </div></script><!-- Window template --><script type=text/ng-template id=window-template.html><div id="create-bordero" class="window-modal" modal-in-class="window-open" ng-style="{\'z-index\': 1000, display: \'block\'}" ng-click="close($event)">\n  <div class="window-inner" ng-transclude></div>\n</div></script>'),e.put("app/admin/rules/template.html","<div class=rules-container><a href=# editable-textarea=rules e-rows=10 e-cols=40 onaftersave=methods.save()><pre>\n      {{ rules || 'Regulamento'}}\n    </pre></a></div>"),e.put("app/admin/schedules/template.html","<div class=schedules-container><div ui-calendar=config.calendar ng-model=events></div></div>"),e.put("app/admin/scores/template.html",'<div class=scores-container><uib-tabset active=1><uib-tab index=0 heading="Classificação geral"><div ng-include="\'app/admin/scores/abas/geral.html\'"></div></uib-tab><uib-tab index=1 heading="Classificação por prova"><div ng-include="\'app/admin/scores/abas/byComps.html\'"></div></uib-tab></uib-tabset></div>'),e.put("app/components/bgCarousel/template.html","<div ng-repeat=\"img in images\" class=image ng-class=\"{ 'visible': active_image == $index }\" ng-style=\"{ 'background-image': 'url(' + img + ')' }\"></div>"),e.put("app/admin/reps/create/template.html",'<div id=modal-rep-create><div class=window-header><h1 class=window-description-header>Cadastrar nova república</h1></div><div class=window-content><form novalidade class=create-form><div class="row input-row"><div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col"><label>Nome:</label><input type=text ng-model=rep.name placeholder=Digite...></div><div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col"><label>Email:</label><input type=text ng-model=rep.email placeholder=Digite...></div></div><div class="row input-row"><div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col"><label>Usúario:</label><input type=text ng-model=rep.user placeholder=Digite...></div><div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 input-col"><label>Senha:</label><input type=text ng-model=rep.password placeholder=Digite...></div></div><div class="row input-row-button"><div class="col-xs-12 col-sm-2 col-md-2 col-lg-2"><button type=button class="btn btn-outline" ng-click=methods.save()>Salvar</button></div></div></form></div><div class=window-footer><button type=button class=btn-outline ng-click=methods.closeModal()>Fechar</button></div></div>'),e.put("app/admin/reps/create/window-template.html","<div id=create-bordero class=window-modal modal-in-class=window-open ng-style=\"{'z-index': 1000, display: 'block'}\" ng-click=close($event)><div class=window-inner ng-transclude></div></div>"),e.put("app/admin/reps/details/template.html",'<div id=modal-rep-details><div class=window-header><h1 class=window-description-header>República {{rep.name}}</h1></div><div class=window-content><table class="table table-striped rep-infos-table"><thead><tr><th class=column-1>Provas</th><th class=column-2>Participantes</th></tr></thead><tbody><tr ng-if=rep.competitions.length ng-repeat="comp in rep.competitions"><td class=column-1>{{comp.name}}</td><td class=column-2><ul ng-repeat="part in comp.team"><li>- {{part}}</li></ul></td></tr><tr ng-if=!rep.competitions.length><td class=no-data-td>Nenhum dado encontrado.</td></tr></tbody></table></div><div class=window-footer><button type=button class=btn-outline ng-click=methods.closeModal()>Fechar</button></div></div>'),e.put("app/admin/reps/details/window-template.html","<div id=create-bordero class=window-modal modal-in-class=window-open ng-style=\"{'z-index': 1000, display: 'block'}\" ng-click=close($event)><div class=window-inner ng-transclude></div></div>"),e.put("app/admin/scores/abas/byComps.html",'<div class=all-comps-results><div class=row><div class="col-xs-8 col-sm-3 col-md-3 col-lg-2 select-comp"><select name=comp-select id=comp-select ng-model=selectedCompetition><option value="" disabled selected>Selecione</option><option ng-repeat="item in allCompetitionsArray" value={{item}}>{{item.name}}</option></select></div></div><div class=row><table class="table table-striped rep-infos-table"><thead><tr><th class=column-1>Posição</th><th class=column-2>Rep</th></tr></thead><tbody><tr ng-if=leaderboard.length ng-repeat="position in leaderboard"><td class=column-1>#{{$index + 1}}</td><td class=column-2><ui-select ng-model=position.rep theme=bootstrap on-select=methods.validateRepsAdded($item)><ui-select-match><span ng-bind=$select.selected.name></span> <button class=ui-select-clear ng-click="methods.validateRepsRemoved($event, $select.selected, $index)">&#10006;</button></ui-select-match><ui-select-choices ui-disable-choice="selectedReps.indexOf(rep) > -1" repeat="rep in reps | filter: $select.search track by $index"><span ng-bind=rep.name></span></ui-select-choices></ui-select></td></tr><tr ng-if=!leaderboard.length><td class=no-data-td>Nenhum dado encontrado.</td></tr></tbody></table></div></div>'),e.put("app/admin/scores/abas/geral.html","geral")}]);
//# sourceMappingURL=../maps/scripts/app-a4c684d9b4.js.map
