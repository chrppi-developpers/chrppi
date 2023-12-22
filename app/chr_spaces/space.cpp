/*
From line 8 to 15
prime<prime( N )> { prime<prime( X )> } -->
candidate<candidate( N )> --> prime<prime( N )>, candidate<candidate( ( N - 1 ) )>

(constraint) prime( ( +int ) ), persistent
(constraint) ##candidate( ( +int ) ), persistent
(rule) candidate( 1 ) <=> success ;;
(rule) candidate( N ) <=> ( candidate( ( N - 1 ) ), prime( N ) ) ;;
(rule) absorb @ prime( Y ) \ prime( X ) <=> ( ( X % Y ) == 0 ) | success ;;
(occ rule) [-candidate( 1 )#0][] --> success ;;
(occ rule) [-candidate( N )#1][] --> ( candidate( ( N - 1 ) ), prime( N ) ) ;;
(occ rule) absorb @ [-prime( X )#0][+prime( Y ), ( ( X % Y ) == 0 )] --> success ;;
(occ rule) absorb @ [+prime( Y )#1][-prime( X ), ( ( X % Y ) == 0 )] --> success ;;

(constraint store) prime( ( +int ) ), persistent
(constraint store) candidate( ( +int ) ), persistent
// Rule NO_NAME, active constraint candidate( 1 ), occurrence 0
Begin candidate_0
	remove constraint candidate( 1 )
	success
	goto next goal constraint
End
// Rule NO_NAME, active constraint candidate( N ), occurrence 1
Begin candidate_1
	remove constraint candidate( N )
	candidate( ( N - 1 ) )
	prime( N )
	goto next goal constraint
End
// Fail through
Begin candidate_store
	Store constraint candidate
Goto next goal constraint
// Rule absorb, active constraint prime( X ), occurrence 0
Begin prime_0
If empty store prime( Y ) Then goto prime_1
	Matching partner prime( Y )
		If guard
			( ( X % Y ) == 0 )
			&& ( prime( Y ) != prime( X ) )
		Then guard
			remove constraint prime( X )
			success
			goto next goal constraint
		End guard
	End matching partner prime( Y )
End
// Rule absorb, active constraint prime( Y ), occurrence 1
Begin prime_1
If empty store prime( X ) Then goto prime_store
	Matching partner prime( X )
		If guard
			( ( X % Y ) == 0 )
			&& ( prime( X ) != prime( Y ) )
		Then guard
			store constraint prime( Y )
			remove constraint prime( X )
			success
			If not alived prime( Y ) Then goto next goal constraint
			goto next matching of prime( X )
		End guard
	End matching partner prime( X )
End
// Fail through
Begin prime_store
	Store constraint prime
Goto next goal constraint
*/
//----------------------- START INCLUDE HEADER ---------------------
/**
 * Prime numbers
 *
 * Use of the Sieve of Eratosthenes to calculate all prime numbers up to a given
 * maximum.
 */
 
//----------------------- END INCLUDE HEADER ---------------------
#include <chrpp.hh>
class PRIMES {
	unsigned long int next_free_constraint_id = 1;
	//(constraint store) prime( ( +int ) ), persistent
public:
	struct prime {
		using Type = typename std::tuple< unsigned long int, chr::Logical_var_ground< int > >;
		using Constraint_store_t = typename chr::Constraint_store_simple< Type, false >;
		class Constraint_callback : public chr::Logical_var_imp_observer_constraint {
		public:
			Constraint_callback(PRIMES* space, typename Constraint_store_t::iterator& it) : _space(space), _it( std::move(it) ) { assert((space != nullptr) && _it.alive()); _it.lock(); }
			Constraint_callback(const Constraint_callback&) =delete;
			void operator=(const Constraint_callback&) =delete;
			~Constraint_callback() { if (!_space.expired() && _space->prime_constraint_store) _it.unlock(); }
			unsigned char run() override {
				if (_space.expired()) return 0;
				if (!_it.alive()) return 0;
				auto& cc = const_cast< Type& >(*_it);
				if ( _space->do_prime(cc, _it) == chr::ES_CHR::FAILURE ) { return 2; }
				return 1;
			}
		private:
			chr::Weak_obj< PRIMES > _space;
			typename Constraint_store_t::iterator _it;
		};
	};
private:
	chr::Shared_obj< typename prime::Constraint_store_t > prime_constraint_store{ chr::make_shared< typename prime::Constraint_store_t >("prime") };
	//(constraint store) candidate( ( +int ) ), persistent
public:
	struct candidate {
		using Type = typename std::tuple< unsigned long int, chr::Logical_var_ground< int > >;
	};
public:
	volatile unsigned int _ref_use_count  = 0;///< Count of shared references
	volatile unsigned int _ref_weak_count = 0;///< Count of weak references + (#shared != 0)
	PRIMES() { }
	~PRIMES() {
		prime_constraint_store.release();
	}
	static chr::Shared_obj<PRIMES> create() { return chr::make_shared<PRIMES>(); }
	chr::Constraint_stores_iterator<chr::Shared_obj<typename prime::Constraint_store_t>> chr_store_begin() { return chr::Constraint_stores_iterator(prime_constraint_store); }
	typename prime::Constraint_store_t& get_prime_store() { return *prime_constraint_store; }
	chr::ES_CHR do_prime(typename prime::Type c_args, typename prime::Constraint_store_t::iterator c_it);
	chr::ES_CHR prime( chr::Logical_var_ground< int > arg0) {
		assert(!chr::failed() && (_ref_use_count >= 1));
		auto c_args = std::make_tuple(next_free_constraint_id++, arg0);
		return do_prime(std::move(c_args), prime_constraint_store->end());
	}
	chr::ES_CHR do_candidate(typename candidate::Type c_args);
	chr::ES_CHR candidate( chr::Logical_var_ground< int > arg0) {
		assert(!chr::failed() && (_ref_use_count >= 1));
		auto c_args = std::make_tuple(next_free_constraint_id++, arg0);
		return do_candidate(std::move(c_args));
	}
};
chr::ES_CHR PRIMES::do_candidate(typename candidate::Type c_args) {
	chr::Statistics::update_call_stack();
	[[maybe_unused]] candidate_call:
	// ***************************************************
	// candidate_0 <=> Rule NO_NAME, active constraint candidate( 1 ), occurrence 1
	[[maybe_unused]] candidate_0:
	{
		if (std::get<1>(c_args) != 1) goto candidate_1;
		// Body
		chr::Statistics::inc_nb_rules();

		return chr::ES_CHR::SUCCESS;
	}
	// ***************************************************
	// candidate_1 <=> Rule NO_NAME, active constraint candidate( N ), occurrence 2
	[[maybe_unused]] candidate_1:
	{
		auto& N = std::get<1>(c_args);
		// Body
		chr::Statistics::inc_nb_rules();
		if (chr::ES_CHR::FAILURE == candidate( ( N - 1 ) )) return chr::ES_CHR::FAILURE;
		if (chr::ES_CHR::FAILURE == prime( N )) return chr::ES_CHR::FAILURE;
		return chr::ES_CHR::SUCCESS;
	}
	// Store constraint
	[[maybe_unused]] candidate_store:
	return chr::ES_CHR::SUCCESS;
}
chr::ES_CHR PRIMES::do_prime(typename prime::Type c_args, typename prime::Constraint_store_t::iterator c_it) {
	bool c_stored_before = !c_it.at_end();
	chr::Statistics::update_call_stack();
	[[maybe_unused]] prime_call:
	// ***************************************************
	// prime_0 <=> Rule absorb, active constraint prime( X ), occurrence 1
	[[maybe_unused]] prime_0:
	{
		if (prime_constraint_store->empty()) goto prime_1;
		auto& X = std::get<1>(c_args);
		auto it0_0 = prime_constraint_store->begin();
		while ( !it0_0.at_end() ) {
			auto Y(std::get<1>(*it0_0));
			// Begin guard
			if (
				( std::get<0>(*it0_0) != std::get<0>(c_args) )
				&& ( ( X % Y ) == 0 )
			) {
				if (c_stored_before) {
					c_it.kill();
				}
				// Body
				chr::Statistics::inc_nb_rules();

				return chr::ES_CHR::SUCCESS;
			} // End guard
			++it0_0;
		}
	}
	// ***************************************************
	// prime_1 <=> Rule absorb, active constraint prime( Y ), occurrence 2
	[[maybe_unused]] prime_1:
	{
		if (prime_constraint_store->empty()) goto prime_store;
		auto& Y = std::get<1>(c_args);
		auto it1_0 = prime_constraint_store->begin();
		while ( !it1_0.at_end() ) {
			auto X(std::get<1>(*it1_0));
			// Begin guard
			if (
				( std::get<0>(*it1_0) != std::get<0>(c_args) )
				&& ( ( X % Y ) == 0 )
			) {
				it1_0.lock();
				if (!c_stored_before) {
					c_it = prime_constraint_store->add(c_args);
					c_stored_before = true;
				}
				c_it.lock();
				it1_0.kill();
				// Body
				chr::Statistics::inc_nb_rules();

				assert(c_stored_before);
				if (!c_it.alive()) {
					c_it.unlock();
					it1_0.unlock();
					return chr::ES_CHR::SUCCESS;
				}
				c_it.unlock();
				it1_0.next_and_unlock();
				goto it1_0_next;
			} // End guard
			++it1_0;
			it1_0_next:;
		}
	}
	// Store constraint
	[[maybe_unused]] prime_store:
		if (!c_stored_before) {
			(void) prime_constraint_store->add( std::move(c_args) );
		}
	return chr::ES_CHR::SUCCESS;
}
//----------------------- START INCLUDE HEADER ---------------------
//----------------------- END INCLUDE HEADER ---------------------

template <typename T>
std::vector<std::string> constraints(T & pb)
{
	std::vector<std::string> constraints;
	for (auto it = pb.chr_store_begin(); !it.at_end(); ++it)
		constraints.push_back(it.to_string());
	return constraints;
}
    